defmodule StatsViewerWeb.PlotLive.Show do
  use StatsViewerWeb, :live_view
  alias StatsViewer.Plots

  @impl true
  def mount(%{"id" => id}, _session, %{assigns: %{current_user: user}} = socket) do
    plot = Plots.get_plot_by!(user, id)

    {:ok,
     socket
     |> assign(:plot, plot)
     |> assign_async(:expression_result, fn ->
       plot.dataset
       |> Plots.get_csv_file_by_name!()
       |> Map.get(:path)
       |> HTTPoison.get([], timeout: 50_000, recv_timeout: 50_000)
       |> then(fn
         {:ok, %{status_code: 200, body: body}} ->
           {:ok,
            %{
              expression_result:
                body
                |> NimbleCSV.RFC4180.parse_string(skip_headers: false)
                |> transform(plot.expression)
            }}
       end)
     end)}
  end

  def transform([headers | rows], expression) do
    rows = Enum.map(rows, &(headers |> Enum.zip(&1) |> Enum.into(%{})))
    regex = ~r|(?<first_value>'[^']+')\s*(?<operator>[+\-*/])\s*(?<second_value>'[^']+')|

    case Regex.named_captures(regex, expression) do
      %{"first_value" => first_value, "operator" => operator, "second_value" => second_value} ->
        value_1 = String.trim(first_value, "'")
        value_2 = String.trim(second_value, "'")

        rows
        |> Enum.reduce_while([], fn row, acc ->
          case apply_operator(row[value_1], operator, row[value_2]) do
            {:ok, result} ->
              {:cont, [result | acc]}

            {:error, error} ->
              {:halt, {:error, error}}
          end
        end)
        |> build_result()

      _ ->
        case Enum.find(headers, &(&1 == expression)) do
          nil ->
            {:error, "could not resolve expression #{expression}"}

          expression ->
            rows
            |> Enum.reduce_while([], fn row, acc ->
              case parse_value(row[expression]) do
                {:ok, value} ->
                  {:cont, [value | acc]}

                {:error, error} ->
                  {:halt, {:error, error}}
              end
            end)
            |> build_result()
        end
    end
  end

  @operators %{
    "+" => &+/2,
    "-" => &-/2,
    "*" => &*/2,
    "/" => &//2
  }
  def apply_operator(left, operator, right) do
    {:ok, left} = parse_value(left)
    {:ok, right} = parse_value(right)

    {:ok, @operators[operator].(left, right)}
  rescue
    _ ->
      {:error, "could not parse values into valid type, please check your expression"}
  end

  defp parse_value(value) when is_binary(value) do
    case Float.parse(value) do
      {value, _} ->
        {:ok, value}

      :error ->
        {:error, "could not parse value #{value}"}
    end
  end

  defp parse_value(value) when is_integer(value), do: value

  defp build_result(result) do
    case result do
      {:error, error} -> {:error, error}
      values -> {:ok, Enum.reverse(values)}
    end
  end
end
