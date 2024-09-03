

export default {
    mounted() {
        var trace = {
            x: JSON.parse(this.el.dataset.values),
            type: 'histogram',
          };
        var data = [trace];
        Plotly.newPlot(this.el.id, data);
    }
  }
  