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
    <button type="button" @click="handleSubmit()">
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
  methods: {
    handleSubmit: function () {
      this.$emit("api-call", this.formData);
      this.formData = { userID: null, username: "", email: "" };
    },
  },
});
</script>

<style lang="scss">
.card {
  &-form,
  &-result {
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2); /* this adds the "card" effect */
    padding: 16px;
    text-align: center;
    background-color: #f7f7f7;
    transition: 0.3s;
    display: flex;
    flex-direction: column;
    width: 100%;

    &:hover {
      box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
    }
  }

  &-result {
    margin: 0 16px;
  }
}

.flexible {
  flex-grow: 1;
}

input[type="text"],
input[type="email"] {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

button[type="button"] {
  background-color: #4caf50;
  color: white;
  width: 100%;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;

  &:hover {
    background-color: #45a049;
  }

  &[disabled="disabled"] {
    background-color: rgb(216, 216, 216);
    color: grey;

    &:hover {
      background-color: rgb(216, 216, 216);
    }
  }
}
</style>
