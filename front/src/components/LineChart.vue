<template>
  <div class="chartLine-wrapper">
    <canvas :id="chartId" />
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-empty-function */
import Vue from "vue";
import Chart, { ChartType } from "chart.js/auto";

export default Vue.extend({
  name: "chart-line",
  props: {
    data: { type: Object, default: () => [] },
    options: { type: Object, default: () => {} },
    chartId: { type: String, default: "chart" },
    type: { type: String, default: "line" }
  },
  mounted(): void {
    const { data, options, chartId, type } = this;
    const ctx = document.getElementById(chartId) as HTMLCanvasElement;
    new Chart(ctx, {
      type: type as ChartType,
      data,
      options,
    })
  },
});
</script>

<style></style>