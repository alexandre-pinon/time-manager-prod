<template>
  <div id="app" class="application">
    <!-- <img alt="Vue logo" src="./assets/logo.png" /> -->
    <User />
    <p>{{allWorkingTimes.data}}</p>
    <Chart chart-id="chart-times" :chart-key="(allWorkingTimes || []).length" :data="computedWTData" :options="chartOptions" />

    <div class="container">
      <div class="chart-wrapper" >
        <Chart style="width: 80%"
          chart-id="chart-bar"
          type="bar"
          :data="chartData"
          :options="chartOptions"
        />
        <Chart style="width: 80%"
          chart-id="chart-line"
          type="line"
          :data="lineChartData"
          :options="chartOptions"
        />
        <Chart style="width: 80%"
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
import moment from "moment";
import _ from "lodash";

import { store } from "@/store";
import { router } from "@/router";
import api from "@/utils/api.ts";

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
      allWorkingTimes:[],
      chartData: {
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
      lineChartData: {
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
      chartOptions: {
        responsive: true,
        lineTension: 1,
        scales: {
          yAxes: [
            {
              ticks: {
                beginAtZero: true,
                padding: 25,
              },
            },
          ],
        },
      },
      pieChartData: {
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
    };
  },
  created() {
    // this.loadWorkingTimes = _.debounce(this.loadWorkingTimes, 300);
    this.loadWorkingTimes();
  },
  watch: {
    computedWTData: function (val: any) {console.log(this.allWorkingTimes, {val})},
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
      const {allWorkingTimes} = this;
      return {
        labels: ((allWorkingTimes as Record<string, any>).data || []).map((wt: any) => wt.id),
        datasets: [
          {
            label: "working time",
            data: ((allWorkingTimes as Record<string, any>).data || []).map((wt: any) => moment(wt.end).diff(moment(wt.start), "hours")),
            backgroundColor: "rgba(71, 183,132,.5)",
            borderColor: "#47b784",
            borderWidth: 3,
          },
        ],
      };
    }
  }
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
