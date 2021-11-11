<template>
  <div class="card-result">
    <h3>RESPONSE</h3>
    <pre>{{ jsonData | pretty }}</pre>
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */

import Vue from "vue";
import { mapState } from "vuex";

export default Vue.extend({
  name: "tm-card-result",
  props: {
    jsonData: {
      type: Object,
      default: function () {
        return {};
      },
    },
  },
  computed: {
    ...mapState(["currentUser"]),
  },
  filters: {
    pretty: function (value: Record<string,any>) {
      return Object.keys(value).length ? JSON.stringify(value, null, 2) : "";
    },
  },
});
</script>

<style lang="scss">
pre {
  white-space: pre-wrap;
  text-align: left;
  font-size: large;
  color: #2c3e50;
  padding: 0 16px;
}
</style>
