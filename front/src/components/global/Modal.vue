<template>
  <div class="modal">
    <div class="modal-body">
      <slot />
    </div>
    <div class="modal-footer flex js-end">
      <Button class="modal-button" @click="$emit('close-modal')"> Fermer </Button>
      <Button class="modal-button" @click="$emit('validate-modal')"> Valider </Button>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from "vue";

import Button from "./Button.vue";

export default Vue.extend({
  name: "tm-modal",
  components: { Button },
  props: {
    hasValidate: Boolean,
  },
});
</script>

<style lang="scss">
div.application {
  .modal {
    position: absolute;
    overflow-y: scroll;
    left: 0;
    right: 0;
    margin: auto;
    padding: 16px;
    max-width: 85vw;
    max-height: 85vh;
    border: 1px solid $border-color;
    border-radius: 4px;
    background: $layer-color;
    color: $text-color;
    &-footer {
      margin-top: 16px;
    }
    &-button {
      margin-left: 16px;
    }
  }
}
</style>