<template>
  <div
    :class="{ 'button flex js-center': true, 'button-small': small }"
    :style="{
      height: height || small ? '32px' : '48px',
      'min-width': height || small ? '32px' : '48px',
    }"
  >
    <router-link v-if="to" class="button-content" :to="to">
      <slot />
    </router-link>
    <div v-else class="button-content" @click="() => $emit('click')">
      <slot />
    </div>
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-empty-function */
import Vue from "vue";

export default Vue.extend({
  name: "tm-button",
  props: {
    small: Boolean,
    to: { type: String, default: undefined },
    height: { type: String, default: "" },
  },
});
</script>

<style lang="scss">
div.application {
  .button {
    background: $accent-color;
    border-radius: 4px;
    padding-left: 8px;
    padding-right: 8px;
    &.button-small {
      &-content {
        font-size: 12pt;
      }
    }
    &-content {
      color: $text-color;
      font-weight: bold;
      font-size: 16pt;
      text-decoration: none;
    }
    &:hover {
      background: $hover-color;
    }
  }
}
</style>
