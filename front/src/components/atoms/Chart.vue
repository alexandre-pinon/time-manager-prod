<template>
  <canvas :id="chartId" />
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-empty-function */
/* eslint-disable @typescript-eslint/no-explicit-any */
import Vue from "vue";
import _ from "lodash";

import Chart, { ChartType } from "chart.js/auto";

export default Vue.extend({
  name: "tm-chart",
  props: {
    data: { type: Object, default: () => [] },
    options: { type: Object, default: () => {} },
    chartId: { type: String, default: "chart" },
    type: { type: String, default: "bar" },
  },
  data() {
    return {
      chart: undefined,
      updated: false,
    };
  },
  created() {
    this.refreshChart = _.debounce(this.refreshChart, 300);
  },
  watch: {
    data: {
      deep: true,
      handler: function (val: any, oldVal: any): void {
        if (!_.isEqual(val, oldVal)) this.updated = false;
        this.refreshChart();
      },
    },
    options: {
      deep: true,
      handler: function (val: any, oldVal: any): void {
        if (!_.isEqual(val, oldVal)) this.updated = false;
        this.refreshChart();
      },
    },
  },
  methods: {
    refreshChart: function (): any {
      const { type, data, options, chartId, chart, updated } = this;
      if (updated) return;
      // console.log("REFRESH ", chartId, { type, data, options, chartId, chart });
      const context: HTMLCanvasElement = document.getElementById(
        chartId
      ) as HTMLCanvasElement;
      if (chart) (this.chart as unknown as Chart)?.update();
      else
        this.$set(
          this,
          "chart",
          new Chart(context, {
            type: type as ChartType,
            data,
            options,
          })
        );
      (this.chart as unknown as Chart)?.render();
      this.updated = true;
    },
  },
});
</script>
