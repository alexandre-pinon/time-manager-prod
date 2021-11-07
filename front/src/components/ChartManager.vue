<template>
  <div class="charts flex">
    <div v-for="(chart, idx) in computedCharts" :key="idx" class="charts-cell">
      <div class="charts-card shadow">
        <Chart v-bind="chart" />
      </div>
    </div>
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */
import mixins from "vue-typed-mixins";
import _ from "lodash";
import moment from "moment";

import { chartColors, chartOptions, generateChartProps } from "@/utils/charts";
import { Chart } from "@/components/atoms";
import { API } from "@/mixins";

export default mixins(API).extend({
  name: "tm-chart-manager",
  components: { Chart },
  data() {
    return {
      allWorkingTimes: {},
    };
  },
  computed: {
    computedCharts(): Array<Record<string, any>> {
      const { allWorkingTimes } = this;
      return [
        {
          chartId: "chart-bar",
          ...generateChartProps(
            "bar",
            { "working time": [6, 5, 8, 9, 7.5] },
            ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
            [chartColors.primaryColor]
          ),
        },
        {
          chartId: "chart-line",
          ...generateChartProps(
            "line",
            {
              "pause": [0, 0, 2, 4, 1],
              "working time": [6, 5, 8, 9, 7.5],
            },
            ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
            [chartColors.secondaryColor, chartColors.primaryColor]
          ),
          chartOptions,
          fill: true
        },
        {
          chartId: "chart-pie",
          ...generateChartProps(
            "pie",
            { "heures d'arrivée": [300, 50, 200, 75] },
            ["7h30", "8h", "8h30", "9h"],
            [
              chartColors.primaryColor,
              chartColors.secondaryColor,
              chartColors.tertiaryColor,
              chartColors.quaternaryColor,
            ],
            { hoverOffset: 4 },
            {
              ...chartOptions,
              scales: {
                y: {
                  grid: {
                    drawBorder: false,
                    display: false,
                  },
                  ticks: {
                    display: false,
                  },
                },
                x: {
                  grid: {
                    drawBorder: false,
                    display: false,
                  },
                  ticks: {
                    display: false,
                  },
                },
              },
            }
          ),
        },
        {
          chartId: "chart-line2",
          ...generateChartProps(
            "line",
            {
              "working time": [8, 10, 6, 8.5, 5],
              "extratime": [2, 4, 0, 3, 0],
              "night working time": [1, 0, 3, 4, 2]
            },
            ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
            [chartColors.secondaryColor, chartColors.primaryColor, chartColors.tertiaryColor]
          ),
        },
        {
          chartId: "chart-wt",
          ...generateChartProps(
            "bar",
            {
              "working time": (
                (allWorkingTimes as Record<string, any>)?.data || []
              ).map((wt: any) =>
                moment(wt.end).diff(moment(wt.start), "hours")
              ),
            },
            ((allWorkingTimes as Record<string, any>)?.data || []).map(
              (wt: any) => wt.id
            ),
            [chartColors.primaryColor]
          ),
        },
      ];
    },
  },
  created() {
    this.loadWorkingTimes();
  },
  methods: {
    async loadWorkingTimes() {
      const tmpUserId = 1;
      const WT = await this.getWorkingTimes(tmpUserId);
      this.$set(this, "allWorkingTimes", WT);
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
      border-radius: 4px;
      height: 100%;
    }
  }
}
</style>
