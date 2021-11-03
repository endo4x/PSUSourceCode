<script>
import { Bar } from 'vue-chartjs'

export default {
  extends: Bar,
  props: ['options'],
  mounted () {
    var bar_ctx = this.$refs.canvas.getContext('2d');

    var background_1 = bar_ctx.createLinearGradient(0, 0, 0, 600);
    background_1.addColorStop(0, '#15CF85');
    background_1.addColorStop(1, '#118478');

    this.chartdata = {
      labels: ['1', '2', '3', '4','5','6','7'],
      cornerRadius: 20,
      datasets: [
        {
          barPercentage: 0.5,
          barThickness: 35,
          maxBarThickness: 35,
          minBarLength: 2,
          backgroundColor: background_1,
          data: [15, 12, 3, 8, 13, 10, 2]
        }
      ]
    }

    this.renderChart(this.chartdata, this.options)
  }
}
</script>

<style>

</style>