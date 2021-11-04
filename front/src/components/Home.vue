<template>
  <div>
    <h1>HOME</h1>
    <ClockManager />
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */

import Vue from "vue";
import { ClockManager } from "@/components";

export default Vue.extend({
  name: "home",
  components: {
    // User,
    ClockManager,
  },
});
</script>

<style lang="scss"></style>
