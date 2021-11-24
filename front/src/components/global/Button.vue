<template>
  <div
    :class="{
      'button flex js-center': true,
      'button-transparent': transparent,
      'button-small': small,
      'button-negative': negative,
      'button-round': round,
    }"
    :style="{
      height: height || small ? '32px' : '48px',
      'min-width': height || small ? '32px' : '48px',
      width: icon ? (height || small ? '32px' : '48px') : 'auto',
    }"
    @click="(event) => $emit('click', event)"
  >
    <router-link
      v-if="to"
      :class="{ 'button-content pointer': true, 'button-content-icon': icon }"
      :to="to"
    >
      <slot />
    </router-link>
    <div
      v-else
      :class="{ 'button-content pointer': true, 'button-content-icon': icon }"
      @click="() => $emit('click')"
    >
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
    negative: Boolean,
    transparent: Boolean,
    icon: Boolean,
    round: Boolean,
    to: { type: String, default: undefined },
    height: { type: String, default: "" },
  },
});
</script>

<style lang="scss">
div.application {
  .button {
    background: $color-primary;
    border-radius: 4px;
    padding-left: 8px;
    padding-right: 8px;
    &.button-round {
      border-radius: 50%;
    }
    &.button-negative {
      background: $color-secondary;
      &:hover {
        background: $color-secondary-hover;
      }
    }
    &.button-transparent {
      background: transparent;
      &:hover {
        background: $color-border;
      }
    }
    &.button-small {
      &-content {
        font-size: 12pt;
      }
    }
    &-content {
      color: $color-text;
      font-weight: bold;
      font-size: 16pt;
      text-decoration: none;
      &-icon {
        height: 24px;
        width: 24px;
      }
    }
    &:hover {
      background: $color-primary-hover;
    }
  }
}
</style>
