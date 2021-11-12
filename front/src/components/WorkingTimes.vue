<template>
  <div class="working-times flex f-column">
    WTs - {{ $route.params.userId || "No userId loaded" }}
    <Card
      v-for="(wt, idx) in workingTimes"
      class="working-times-card"
      :key="idx"
    >
      {{ wt.start }} - {{ wt.end }}
    </Card>
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */
import mixins from "vue-typed-mixins";
import _ from "lodash";
import { mapState } from "vuex";

import { Card } from "@/components/global";
import { API } from "@/mixins";

export default mixins(API).extend({
  name: "tm-working-times",
  components: { Card },
  computed: {
    ...mapState(["currentUser"]),
  },
  data() {
    return {
      workingTimes: [],
    };
  },
  created() {
    this.loadWorkingTimes();
  },
  methods: {
    loadWorkingTimes: async function (): Promise<void> {
      const { $route: route } = this;
      const { userId } = route?.params || {};
      if (!+userId) return;
      const { data } = (await this.getWorkingTimes(+userId)) || {};
      this.$set(this, "workingTimes", _.orderBy(data || [], "start", "desc"));
    },
  },
});
</script>
