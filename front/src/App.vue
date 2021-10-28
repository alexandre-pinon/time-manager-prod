<template>
  <div id="app" class="application">
    <!-- <img alt="Vue logo" src="./assets/logo.png" /> -->
    <User />
    <ExampleChart chart-id="chart-example" type="bar" :data="chartData" :options="chartOptions" />
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import VueRouter from "vue-router";

import { store } from "@/store";
import { router } from "@/router";

import { User, ExampleChart } from "@/components";

Vue.use(VueRouter);

export default Vue.extend({
  name: "App",
  store,
  router,
  data() {
    return {
      chartData: {
        labels: ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"],
        datasets: [
          {
            label: "Number of Moons",
            data: [0, 0, 1, 2, 79, 82, 27, 14],
            backgroundColor: "rgba(54,73,93,.5)",
            borderColor: "#36495d",
            borderWidth: 3
          },
          {
            label: "Planetary Mass (relative to the Sun x 10^-6)",
            data: [0.166, 2.081, 3.003, 0.323, 954.792, 285.886, 43.662, 51.514],
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
    };
  },
  components: {
    User,
    ExampleChart,
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
}
</style>
