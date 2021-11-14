<template>
  <div
    :class="{
      'card shadow flex': true,
      'card-full-width': fullWidth,
      'f-column': !row,
      'js-even': !edgeSpacing,
      'js-between': edgeSpacing,
    }"
  >
    <slot />
  </div>
</template>

<script lang="ts">
import Vue from "vue";

export default Vue.extend({
  name: "tm-card",
  props: {
    fullWidth: Boolean,
    row: Boolean,
    edgeSpacing: Boolean,
  },
});
</script>

<style lang="scss">
div.application {
  .card {
    border-radius: 4px;
    padding: 16px;
    &-full-width {
      width: 100%;
    }
  }
}
</style>
