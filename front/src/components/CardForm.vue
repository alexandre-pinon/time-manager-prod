<template>
  <div class="card-form">
    <h3>{{ title }}</h3>
    <template v-for="(input, index) in inputs">
      <div :key="index">
        <label :for="input.name">{{ input.label }}</label>
        <input v-model="formData[input.name]" type="text" :id="input.name" />
      </div>
    </template>
    <div class="flexible"></div>
    <button type="button" @click="$emit('api-call', formData)">
      {{ action }}
    </button>
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */

import Vue from "vue";
import { mapState } from "vuex";

export default Vue.extend({
  name: "tm-card-form",
  props: {
    title: String,
    action: String,
    apiCallEvent: String,
    jsonData: Object,
    inputs: Array,
  },
  computed: {
    ...mapState(["currentUser"]),
  },
  data() {
    return {
      formData: { userID: null, username: "", email: "" },
    };
  },
});
</script>
