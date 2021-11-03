<template>
  <div class="charts flex">
    <div v-for="(chart, idx) in computedCharts" :key="idx" class="charts-cell">
      <div class="charts-card">
        <Chart v-bind="chart" />
      </div>
    </div>
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */
import Vue from "vue";
import _ from "lodash";
import moment from "moment";

import { generateChartData, chartOptions, chartColors } from "@/utils/charts";
import api from "@/utils/api";

import { Chart } from "@/components/atoms";

export default Vue.extend({
  name: "tm-chart-manager",
  components: { Chart },
  data() {
    return {
      allWorkingTimes: {},
    };
  },
  computed: {
    computedCharts(): Array<Record<string, any>> {
      const { computedWorkingTimesData } = this;
      return [
        {
          chartId: "chart-bar",
          data: generateChartData(
            { "working time": [6, 5, 8, 9, 7.5] },
            ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
            [chartColors.accentColor]
          ),
          options: chartOptions,
        },
        {
          chartId: "chart-line",
          type: "line",
          data: generateChartData(
            {
              "working time target": [7, 7, 7, 7, 7],
              "working time": [6, 5, 8, 9, 7.5],
            },
            ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
            [chartColors.accentColor, chartColors.hoverColor]
          ),
          options: chartOptions,
        },
        {
          chartId: "chart-pie",
          type: "pie",
          data: generateChartData(
            { "heures d'arrivée": [300, 50, 200, 75, 100] },
            ["7h30, 8h, 8h30, 9h, 9h30"],
            [chartColors.accentColor],
            { hoverOffset: 4 }
          ),
          options: chartOptions,
        },
        {
          chartId: "chart-wt",
          data: computedWorkingTimesData,
          options: chartOptions,
        },
      ];
    },
    computedWorkingTimesData(): Record<string, any> {
      const { allWorkingTimes } = this;
      return {
        labels: ((allWorkingTimes as Record<string, any>)?.data || []).map(
          (wt: any) => wt.id
        ),
        datasets: [
          {
            label: "working time",
            data: ((allWorkingTimes as Record<string, any>)?.data || []).map(
              (wt: any) => moment(wt.end).diff(moment(wt.start), "hours")
            ),
            backgroundColor: chartColors.accentColor,
            borderColor: chartColors.hoverColor,
            borderWidth: 3,
          },
        ],
      };
    },
  },
  created() {
    this.loadWorkingTimes();
  },
  methods: {
    async loadWorkingTimes() {
      const tmpUserId = 1
      const WT = await api.getWorkingTimes(tmpUserId);
      this.$set(this, "allWorkingTimes", WT);
      console.log(this.allWorkingTimes);
    },
  },
});
</script>

<style lang="scss">
div.application {
  .charts {
    &-cell {
      padding: 8px;
      width: 50%;
      height: 250px;
    }
    &-card {
      // border: 1px solid $border-color;
      background-color: $layer-color;
      border-radius: 8px;
      height: 100%;
    }
  }
}
</style>
