<template>
  <div class="chart">
    <canvas :id="chartId" />
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-empty-function */
import Vue from "vue";
import Chart, { ChartType, ChartItem } from "chart.js/auto";

export default Vue.extend({
  name: "tm-chart",
  props: {
    data: { type: Object, default: () => [] },
    options: { type: Object, default: () => {} },
    chartId: { type: String, default: "chart" },
    type: { type: String, default: "bar" },
    chartKey: {type: Number, default: 0},
  },
  data() {
    return {
      chart: undefined,
    };
  },
  watch: {
    chartKey: function (val: any) {
      const {type, data, options, chartId, chart} = this;
      const context: HTMLCanvasElement = document.getElementById(chartId) as HTMLCanvasElement;
      if (chart) {
        (this.chart as unknown as Chart).destroy();
        this.chart = undefined;
      };
      this.$set(this, "chart", new Chart(context, {
        type: type as ChartType,
        data,
        options,
      }));
    },
  },
});
</script>

<style></style>
