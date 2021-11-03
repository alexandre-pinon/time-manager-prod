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
import Vue from "vue";
import _ from "lodash";
import moment from "moment";

import { chartColors, generateChartProps } from "@/utils/charts";
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
              "working time target": [7, 7, 7, 7, 7],
              "working time": [6, 5, 8, 9, 7.5],
            },
            ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
            [chartColors.secondaryColor, chartColors.primaryColor]
          ),
        },
        {
          chartId: "chart-pie",
          ...generateChartProps(
            "pie",
            { "heures d'arrivée": [300, 50, 200, 75, 100] },
            ["7h30, 8h, 8h30, 9h, 9h30"],
            [chartColors.primaryColor],
            { hoverOffset: 4 }
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
      const WT = await api.getWorkingTimes(tmpUserId);
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
      border: 1px solid var(--color-border);
      border-radius: 4px;
      height: 100%;
    }
  }
}
</style>
