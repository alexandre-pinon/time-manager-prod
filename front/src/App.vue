<template>
  <div id="app" class="application">
    <router-link to="/">Home</router-link>
    <router-link to="/workingtimes/:userId">Go to Bar</router-link>
    <router-link to="/workingtime/:userId">Go to Bar</router-link>
    <router-link to="/workingtime/:userId/:workingTimeId"
      >Go to Bar</router-link
    >
    <User />
    <router-view></router-view>

    <div class="container">
      <div class="chart-wrapper">
        <Chart
          chart-id="chart-bar"
          type="bar"
          :data="chartData"
          :options="chartOptions"
        />
        <Chart
          chart-id="chart-line"
          type="line"
          :data="lineChartData"
          :options="chartOptions"
        />
        <Chart
          chart-id="chart-pie"
          type="pie"
          :data="chartData"
          :options="chartOptions"
        />
        <Chart
          chart-id="chart-times"
          :data="computedWTData"
          :options="chartOptions"
        />
      </div>
    </div>
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable @typescript-eslint/no-this-alias */
import Vue from "vue";
import VueRouter from "vue-router";
import moment from "moment";
import _ from "lodash";

import { store } from "@/store";
import { router } from "@/router";
import { generateChartData, chartOptions } from "@/utils/charts";
import api from "@/utils/api";

import { User, Chart } from "@/components";

Vue.use(VueRouter);

export default Vue.extend({
  name: "App",
  store,
  router,
  components: {
    User,
    Chart,
  },
  data() {
    return {
      allWorkingTimes: undefined,
      chartData: generateChartData(
        { "working time": [6, 5, 8, 9, 7.5] },
        ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
        ["rgba(71, 183,132,.5)"]
      ),
      lineChartData: generateChartData(
        {
          "working time target": [7, 7, 7, 7, 7],
          "working time": [6, 5, 8, 9, 7.5],
        },
        ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
        ["rgba(54,73,93,.5)", "rgba(71, 183,132,.5)"]
      ),
      pieChartData: generateChartData(
        { "heures d'arrivée": [300, 50, 200, 75, 100] },
        ["7h30, 8h, 8h30, 9h, 9h30"],
        ["rgba(255, 99, 132, 1)"],
        { hoverOffset: 4 }
      ),
      chartOptions,
    };
  },
  created() {
    this.loadWorkingTimes();
  },
  watch: {
    computedWTData: function (val: any) {
      console.log(this.allWorkingTimes, { val });
    },
  },
  methods: {
    async loadWorkingTimes() {
      this.$set(this, "allWorkingTimes", []);
      const WT = await api.getAllWorkingTimes();
      this.$set(this, "allWorkingTimes", WT);
    },
  },
  computed: {
    computedWTData() {
      const vm: any = this;
      const { allWorkingTimes } = vm;
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
            backgroundColor: "rgba(71, 183,132,.5)",
            borderColor: "#47b784",
            borderWidth: 3,
          },
        ],
      };
    },
  },
});
</script>

<style lang="scss">
div.application {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;

  .container {
    margin: auto;
    width: 80%;

    .chart-wrapper {
      align-items: baseline;
      display: flex;
      margin: auto;

      * {
        margin: 30px 0;
      }
    }
  }
}
</style>
