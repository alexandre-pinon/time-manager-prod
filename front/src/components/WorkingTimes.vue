<template>
  <div class="working-times flex f-column">
    <h2>Vos heures de travail</h2>
    <Card
      v-for="(day, key) in workingTimes"
      class="working-times-card"
      full-width
      :key="key"
    >
      <h3>{{ key }}</h3>
      <h4>{{ computeBorders(day) }}</h4>
      <div
        v-for="(wt, idx) in computeOrderedDay(day)"
        class="working-times-detail"
        :key="idx"
      >
        {{ computeHour(wt.start || "") }} -
        {{ computeHour(wt.end || "") }}
      </div>
    </Card>
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */
import mixins from "vue-typed-mixins";
import _ from "lodash";
import moment from "moment";
import { mapState } from "vuex";

import { Card } from "@/components/global";
import { API } from "@/mixins";

export default mixins(API).extend({
  name: "tm-working-times",
  components: { Card },
  computed: {
    ...mapState(["currentUser", "workingTimes"]),
  },
  methods: {
    computeHour: function (date: string): string {
      if (!date) return "Heure inconnue";
      return moment(date).format("HH:mm");
    },
    computeOrderedDay: function (
      entries: Array<Record<string, any>>
    ): Array<Record<string, any>> {
      return _.orderBy(entries, "start", "asc");
    },
    computeBorders: function (entries: Array<Record<string, any>>): string {
      const orderedEntries = this.computeOrderedDay(entries);
      return (
        moment(_.head(orderedEntries)?.start).format("HH:mm") +
        " > " +
        moment(_.last(orderedEntries)?.end).format("HH:mm")
      );
    },
  },
});
</script>

<style lang="scss">
div.application {
  .working-times {
    width: 100%;
    &-card {
      margin-top: 8px;
    }
  }
}
</style>
