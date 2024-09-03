defmodule StatsViewer.PlotsTest do
  use StatsViewer.DataCase

  alias StatsViewer.Plots

  describe "plots" do
    alias StatsViewer.Plots.Plot

    import StatsViewer.PlotsFixtures

    @invalid_attrs %{name: nil, dataset: nil, expression: nil}

    test "list_plots/0 returns all plots" do
      plot = plot_fixture()
      assert Plots.list_plots() == [plot]
    end

    test "get_plot!/1 returns the plot with given id" do
      plot = plot_fixture()
      assert Plots.get_plot!(plot.id) == plot
    end

    test "create_plot/1 with valid data creates a plot" do
      valid_attrs = %{name: "some name", dataset: "some dataset", expression: "some expression"}

      assert {:ok, %Plot{} = plot} = Plots.create_plot(valid_attrs)
      assert plot.name == "some name"
      assert plot.dataset == "some dataset"
      assert plot.expression == "some expression"
    end

    test "create_plot/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Plots.create_plot(@invalid_attrs)
    end

    test "update_plot/2 with valid data updates the plot" do
      plot = plot_fixture()

      update_attrs = %{
        name: "some updated name",
        dataset: "some updated dataset",
        expression: "some updated expression"
      }

      assert {:ok, %Plot{} = plot} = Plots.update_plot(plot, update_attrs)
      assert plot.name == "some updated name"
      assert plot.dataset == "some updated dataset"
      assert plot.expression == "some updated expression"
    end

    test "update_plot/2 with invalid data returns error changeset" do
      plot = plot_fixture()
      assert {:error, %Ecto.Changeset{}} = Plots.update_plot(plot, @invalid_attrs)
      assert plot == Plots.get_plot!(plot.id)
    end

    test "delete_plot/1 deletes the plot" do
      plot = plot_fixture()
      assert {:ok, %Plot{}} = Plots.delete_plot(plot)
      assert_raise Ecto.NoResultsError, fn -> Plots.get_plot!(plot.id) end
    end

    test "change_plot/1 returns a plot changeset" do
      plot = plot_fixture()
      assert %Ecto.Changeset{} = Plots.change_plot(plot)
    end
  end

  describe "csv_files" do
    alias StatsViewer.Plots.CSVFile

    import StatsViewer.PlotsFixtures

    @invalid_attrs %{}

    test "list_csv_files/0 returns all csv_files" do
      csv_file = csv_file_fixture()
      assert Plots.list_csv_files() == [csv_file]
    end

    test "get_csv_file!/1 returns the csv_file with given id" do
      csv_file = csv_file_fixture()
      assert Plots.get_csv_file!(csv_file.id) == csv_file
    end

    test "create_csv_file/1 with valid data creates a csv_file" do
      valid_attrs = %{}

      assert {:ok, %CSVFile{} = csv_file} = Plots.create_csv_file(valid_attrs)
    end

    test "create_csv_file/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Plots.create_csv_file(@invalid_attrs)
    end

    test "update_csv_file/2 with valid data updates the csv_file" do
      csv_file = csv_file_fixture()
      update_attrs = %{}

      assert {:ok, %CSVFile{} = csv_file} = Plots.update_csv_file(csv_file, update_attrs)
    end

    test "update_csv_file/2 with invalid data returns error changeset" do
      csv_file = csv_file_fixture()
      assert {:error, %Ecto.Changeset{}} = Plots.update_csv_file(csv_file, @invalid_attrs)
      assert csv_file == Plots.get_csv_file!(csv_file.id)
    end

    test "delete_csv_file/1 deletes the csv_file" do
      csv_file = csv_file_fixture()
      assert {:ok, %CSVFile{}} = Plots.delete_csv_file(csv_file)
      assert_raise Ecto.NoResultsError, fn -> Plots.get_csv_file!(csv_file.id) end
    end

    test "change_csv_file/1 returns a csv_file changeset" do
      csv_file = csv_file_fixture()
      assert %Ecto.Changeset{} = Plots.change_csv_file(csv_file)
    end
  end
end
