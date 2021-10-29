<template>
  <div id="app" class="application">
    <!-- <img alt="Vue logo" src="./assets/logo.png" /> -->
    <User />
    <ExampleChart chart-id="chart-example" type="bar" :data="chartData" :options="chartOptions" />
    <LineChart chart-id="chart-line" type="line" :data="lineChartData" :options="chartOptions" />
    <PieChart chart-id="chart-pie" type="pie" :data="chartData" :options="chartOptions" />
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import VueRouter from "vue-router";

import { store } from "@/store";
import { router } from "@/router";

import { User, ExampleChart, LineChart } from "@/components";
import PieChart from "./components/PieChart.vue"

Vue.use(VueRouter);

export default Vue.extend({
  name: "App",
  store,
  router,
  data() {
    return {
      chartData: {
        labels: ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
        datasets: [
          {
            label: "working time",
            data: [6, 5, 8, 9, 7.5],
            backgroundColor: "rgba(71, 183,132,.5)",
            borderColor: "#47b784",
            borderWidth: 3
          }
        ]
      },
      lineChartData: {
        labels: ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"],
        datasets: [
          {
            label: "working time target",
            data: [7, 7, 7, 7, 7],
            backgroundColor: "rgba(54,73,93,.5)",
            borderColor: "#36495d",
            borderWidth: 3
          },
          {
            label: "working time",
            data: [6, 5, 8, 9, 7.5],
            backgroundColor: "rgba(71, 183,132,.5)",
            borderColor: "#47b784",
            borderWidth: 3
          }
        ]
      },
      chartOptions: {
        responsive: true,
        lineTension: 1,
        scales: {
          yAxes: [
            {
              ticks: {
                beginAtZero: true,
                padding: 25
              }
            }
          ]
        }
      },
      pieChartData: {
        labels: ["7h30, 8h, 8h30, 9h, 9h30"],
        dataset: [
          {
            label: ["heures d'arrivée"],
            data: [300, 50, 200, 75, 100],
            backgroundColor: [
              'rgb(255, 99, 132)',
              'rgb(54, 162, 235)',
              'rgb(255, 205, 86)'
            ]
          }
        ],
        hoverOffset: 4
      }
    };
  },
  components: {
    User,
    ExampleChart,
    LineChart, 
    PieChart
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
  width: 50%
}
</style>
