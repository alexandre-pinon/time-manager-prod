<template>
  <div>WORKING TIMES</div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */

import Vue from "vue";
import { mapState } from "vuex";

export default Vue.extend({
  name: "tm-working-times",
  props: {},
  computed: {
    ...mapState(["currentUser"]),
  },
  data() {
    return {};
  },
  methods: {},
});
</script>
