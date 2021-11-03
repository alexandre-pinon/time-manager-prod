<template>
  <router-link v-if="to" class="button" :to="to">
    <slot />
  </router-link>
  <div v-else class="button" @click="() => onClick()">
    <slot />
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-empty-function */
import Vue from "vue";

export default Vue.extend({
  name: "tm-button",
  props: {
    to: { type: String, default: "" },
    onClick: { type: Function, default: () => {} },
  },
});
</script>

<style lang="scss">
div.application {
  .button {
    padding: 8px;
    background: $accent-color;
    color: $text-color;
    font-weight: bold;
    font-size: 16pt;
    text-decoration: none;
    border-radius: 8px;
    &:hover {
      background: $hover-color;
    }
  }
}
</style>
