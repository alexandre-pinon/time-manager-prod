<template>
  <div class="card shadow flex js-center">
    <slot />
  </div>
</template>

<script lang="ts">
import Vue from "vue";

export default Vue.extend({
  name: "tm-card",
});
</script>

<style lang="scss">
div.application {
  .card {
    border-radius: 4px;
  }
}
</style>