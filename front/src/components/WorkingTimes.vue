<template>
  <div class="working-times flex f-column">
    WTs - {{ computedUserId || "No userId loaded" }}
    <Card
      v-for="(wt, idx) in workingTimes"
      class="working-times-card"
      :key="idx"
    >
      {{ wt }}
    </Card>
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */
import Vue from "vue";
import _ from "lodash";

import { mapState } from "vuex";

import api from "@/utils/api";
import { Card } from "@/components/global";

export default Vue.extend({
  name: "tm-working-times",
  components: { Card },
  computed: {
    computedUserId: function (): number {
      const { currentUser, $route: route } = this;
      const { id: currentUserId } = currentUser;
      const { userId } = route?.params || {};
      return currentUserId && +userId === +currentUserId ? currentUserId : 0;
    },
    ...mapState(["currentUser"]),
  },
  data() {
    return {
      workingTimes: [],
    };
  },
  created() {
    this.getWorkingTimes();
  },
  watch: {
    computedUserId: function (): void {
      this.getWorkingTimes();
    },
  },
  methods: {
    getWorkingTimes: async function (): Promise<void> {
      const { computedUserId } = this;
      if (!computedUserId) return;
      const { data } = (await api.getWorkingTimes(computedUserId)) || {};
      this.$set(this, "workingTimes", data || []);
    },
  },
});
</script>
