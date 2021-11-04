<template>
  <div class="clock-manager flex f-column">
    Clock - {{ computedUsername || "No username loaded" }}
    <Card class="clock-manager-content">
      {{ startDateTime + " - il y a " + computedTimer }}
      <Button @click="() => clock()"> Changer de statut </Button>
    </Card>
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */
import Vue from "vue";

import { mapState } from "vuex";

import { Card, Button } from "@/components/global";

export default Vue.extend({
  name: "tm-clock-manager",
  components: { Card, Button },
  data() {
    return {
      startDateTime: undefined,
      clockIn: false,
    };
  },
  computed: {
    computedUsername: function (): string {
      const { currentUser, $route: route } = this;
      const { username: currentUsername } = currentUser;
      const { username } = route?.params || {};
      return currentUsername && username === currentUsername
        ? currentUsername
        : "";
    },
    computedUserId: function (): number {
      const { currentUser, computedUsername } = this;
      const { currentUserId, currentUsername } = currentUser;
      return currentUsername === computedUsername ? +currentUserId : 0;
    },
    ...mapState(["currentUser"]),
  },
  created() {
    this.refresh();
  },
  methods: {
    refresh: async function (): Promise<void> {
      return;
    },
  },
});
</script>
