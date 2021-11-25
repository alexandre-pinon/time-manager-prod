<template>
  <div class="charts flex">
    <div v-for="(chart, idx) in charts" :key="idx" class="charts-card shadow">
      <h3>{{ chart.title || "No title" }}</h3>
      <div class="charts-card-content">
        <Chart v-bind="chart" />
      </div>
    </div>
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable @typescript-eslint/no-empty-function */
import mixins from "vue-typed-mixins";
import _ from "lodash";
import moment from "moment";
import { mapState } from "vuex";

import { chartColors, generateChartProps } from "@/utils/charts";
import { Chart } from "@/components/atoms";
import { API } from "@/mixins";
import { chainPromises } from "@/utils/helpers";

export default mixins(API).extend({
  name: "tm-chart-manager",
  components: { Chart },
  props: {
    selectedUser: { type: Object, default: () => {} },
    selectedTeam: { type: Object, default: () => {} },
    isOverseer: Boolean,
  },
  data() {
    return {
      charts: [],
      userWorkingTimes: {},
      teamWorkingTimes: {},
    };
  },
  computed: {
    computedWorkingTimes(): Array<any> {
      const { workingTimes, userWorkingTimes, isOverseer } = this;
      const wt = isOverseer ? userWorkingTimes : workingTimes;
      const days = _.keys(wt).map((val: string) =>
        moment(val, "DD/MM/YY").day()
      );
      const newArr = _.fill(new Array(7), []);
      return newArr.map((_: any, idx: number) =>
        days.includes(idx) ? Object.values(wt)[days.indexOf(idx)] : []
      );
    },
    computedHours(): Array<any> {
      const { computedWorkingTimes } = this;
      return computedWorkingTimes.map((arr: any) => ({
        total: _.sumBy(arr, (el: any) =>
          Math.abs(
            moment.duration(moment(el?.start).diff(moment(el?.end))).asHours()
          )
        ),
        night: _.sumBy(
          arr.filter((el: any) => {
            const startRef = moment(el?.start).hour(20);
            const endRef = moment(el?.end).hour(6);
            return (
              moment(el?.start).isBetween(startRef, endRef) ||
              moment(el?.end).isBetween(startRef, endRef)
            );
          }),
          (el: any) => {
            const startRef = moment(el?.start).hour(20);
            const endRef = moment(el?.end).hour(6);
            return Math.abs(
              moment
                .duration(
                  moment
                    .max(moment(el?.start), startRef)
                    .diff(moment.min(moment(el?.end), endRef))
                )
                .asHours()
            );
          }
        ),
        overtime: Math.max(
          0,
          _.sumBy(arr, (el: any) =>
            Math.abs(
              moment.duration(moment(el?.start).diff(moment(el?.end))).asHours()
            )
          ) - 7
        ),
      }));
    },
    ...mapState(["workingTimes", "currentUser", "isManager", "isAdmin"]),
  },
  watch: {
    computedHours: {
      deep: true,
      immediate: true,
      handler: function () {
        this.computeCharts();
      },
    },
    isOverseer: {
      immediate: true,
      deep: true,
      handler: function () {
        this.computeCharts();
      },
    },
    selectedUser: function () {
      this.loadUserWorkingTimes();
    },
    selectedTeam: function () {
      this.loadTeamWorkingTimes();
    },
  },
  methods: {
    computeCharts: async function () {
      const { computedHours, isOverseer, teamWorkingTimes } = this;
      const charts = !isOverseer
        ? [
            {
              title: "Temps de travail/Objectif",
              chartId: "chart-bar",
              ...generateChartProps(
                "bar",
                {
                  "Heures travaillées": _.map(computedHours, "total"),
                  Objectif: [0, 7, 7, 7, 7, 7, 0],
                },
                [
                  "Dimanche",
                  "Lundi",
                  "Mardi",
                  "Mercredi",
                  "Jeudi",
                  "Vendredi",
                  "Samedi",
                ],
                [chartColors.primaryColor, chartColors.secondaryColor]
              ),
            },
            {
              title: "Décomposition temps de travail",
              chartId: "chart-detail",
              ...generateChartProps(
                "line",
                {
                  "Heures travaillées": _.map(computedHours, "total"),
                  "Heures de nuit": _.map(computedHours, "night"),
                  "Heures supplémentaires": _.map(computedHours, "overtime"),
                },
                [
                  "Dimanche",
                  "Lundi",
                  "Mardi",
                  "Mercredi",
                  "Jeudi",
                  "Vendredi",
                  "Samedi",
                ],
                [
                  chartColors.secondaryColor,
                  chartColors.primaryColor,
                  chartColors.tertiaryColor,
                ]
              ),
            },
          ]
        : [
            {
              title: "Temps de travail employé",
              chartId: "chart-user-bar",
              ...generateChartProps(
                "bar",
                {
                  "Heures travaillées": _.map(computedHours, "total"),
                },
                [
                  "Dimanche",
                  "Lundi",
                  "Mardi",
                  "Mercredi",
                  "Jeudi",
                  "Vendredi",
                  "Samedi",
                ],
                [chartColors.primaryColor]
              ),
            },
            {
              title: "Temps de travail/Objectif",
              chartId: "chart-team-detail",
              ...generateChartProps(
                "line",
                {
                  "Heures travaillées": _.map(teamWorkingTimes, (userWt: any) =>
                    _.sum(
                      _.map(_.values(userWt), (userDay: any) =>
                        _.sumBy(userDay, (el: any) =>
                          Math.abs(
                            moment
                              .duration(moment(el?.start).diff(moment(el?.end)))
                              .asHours()
                          )
                        )
                      )
                    )
                  ),
                  Objectif: _.map(teamWorkingTimes, () => 35),
                },
                _.map(teamWorkingTimes, (usr: any, idx: number) => idx),
                [chartColors.primaryColor, chartColors.secondaryColor]
              ),
            },
          ];
      this.$set(this, "charts", charts);
    },
    loadUserWorkingTimes: async function () {
      const { selectedUser } = this;
      const { id: userId } = selectedUser || {};
      if (!+userId) return;
      const { data } =
        (await this.getWorkingTimes(
          +userId,
          moment().startOf("week").format("YYYY-MM-DD"),
          moment().endOf("week").format("YYYY-MM-DD")
        )) || {};
      this.$set(
        this,
        "userWorkingTimes",
        _.groupBy(_.orderBy(data || [], "start", "desc"), (data: any) =>
          moment(data?.start).format("DD/MM/YY")
        )
      );
      await this.computeCharts();
    },
    loadTeamWorkingTimes: async function () {
      const { selectedTeam } = this;
      const { users } = selectedTeam || {};
      if (!users?.length) return;
      const promises: any[] = [];
      users.forEach((usr: any) =>
        promises.push(
          this.getWorkingTimes(
            +usr?.id,
            moment().startOf("week").format("YYYY-MM-DD"),
            moment().endOf("week").format("YYYY-MM-DD")
          )
        )
      );
      const data = await chainPromises(promises);
      this.$set(
        this,
        "teamWorkingTimes",
        data.map((userWt: any) =>
          _.groupBy(
            _.orderBy(userWt?.data || [], "start", "desc"),
            (data: any) => moment(data?.start).format("DD/MM/YY")
          )
        )
      );
      await this.computeCharts();
    },
  },
});
</script>

<style lang="scss">
div.application {
  .charts {
    &-card {
      border-radius: 4px;
      padding: 8px;
      margin: 8px;
      max-width: 100vw;
      min-width: 49vw;
      flex-grow: 1;
      flex-shrink: 1;
      &-content {
        height: 80%;
      }
    }
  }
}
@media screen and (max-width: 600px) {
  div.application {
  .charts {
    &-card {
      border-radius: 4px;
      padding: 8px;
      margin: 8px;
      max-width: 100%;
      min-width: 95%;
      flex-grow: 1;
      flex-shrink: 0;
      &-content {
        height: 80%;
      }
    }
  }
}
}
</style>
