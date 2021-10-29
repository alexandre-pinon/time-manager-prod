<template>
  <div id="app" class="application">
    <!-- <img alt="Vue logo" src="./assets/logo.png" /> -->
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
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import VueRouter from "vue-router";

import { store } from "@/store";
import { router } from "@/router";
import { generateChartData, chartOptions } from "@/utils/charts";

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
      chartData2: {
        labels: ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
        datasets: [
          {
            label: "working time",
            data: [6, 5, 8, 9, 7.5],
            backgroundColor: "rgba(71, 183,132,.5)",
            borderColor: "#47b784",
            borderWidth: 3,
          },
        ],
      },
      chartData: generateChartData(
        { "working time": [6, 5, 8, 9, 7.5] },
        ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
        ["rgba(71, 183,132,.5)"]
      ),
      lineChartData2: {
        labels: ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
        datasets: [
          {
            label: "working time target",
            data: [7, 7, 7, 7, 7],
            backgroundColor: "rgba(54,73,93,.5)",
            borderColor: "#36495d",
            borderWidth: 3,
          },
          {
            label: "working time",
            data: [6, 5, 8, 9, 7.5],
            backgroundColor: "rgba(71, 183,132,.5)",
            borderColor: "#47b784",
            borderWidth: 3,
          },
        ],
      },
      lineChartData: generateChartData(
        {
          "working time target": [7, 7, 7, 7, 7],
          "working time": [6, 5, 8, 9, 7.5],
        },
        ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
        ["rgba(54,73,93,.5)", "rgba(71, 183,132,.5)"],
        { borderWidth: 2 }
      ),
      pieChartData2: {
        labels: ["7h30, 8h, 8h30, 9h, 9h30"],
        dataset: [
          {
            label: ["heures d'arrivée"],
            data: [300, 50, 200, 75, 100],
            backgroundColor: [
              "rgb(255, 99, 132)",
              "rgb(54, 162, 235)",
              "rgb(255, 205, 86)",
            ],
          },
        ],
        hoverOffset: 4,
      },
      pieChartData: generateChartData(
        { "heures d'arrivée": [300, 50, 200, 75, 100] },
        ["7h30, 8h, 8h30, 9h, 9h30"],
        ["rgba(255, 99, 132, 1)"],
        { hoverOffset: 4 }
      ),
      chartOptions,
    };
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
      max-width: 50%;
      margin: auto;

      * {
        margin: 30px 0;
      }
    }
  }
}
</style>
