<template>
  <div class="modal">
    <div class="modal-body">
      <slot />
    </div>
    <div class="modal-footer flex js-end">
      <Button
        v-if="!hideClose"
        class="modal-button"
        negative
        @click="$emit('close-modal')"
      >
        Fermer
      </Button>
      <Button
        v-if="hasValidate"
        class="modal-button"
        @click="$emit('validate-modal')"
      >
        Valider
      </Button>
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
    hideClose: Boolean,
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
    min-width: 15vw;
    max-width: 85vw;
    min-height: 15vh;
    max-height: 85vh;
    border: 1px solid $color-border;
    border-radius: 4px;
    background: $color-background;
    color: $color-text;
    &-footer {
      margin-top: 16px;
    }
    &-button {
      margin-left: 16px;
    }
  }
}
</style>
