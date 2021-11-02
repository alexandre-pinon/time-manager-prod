<template>
  <div class="navbar flex js-center">
    <Button
      v-for="(link, idx) in links"
      class="navbar-link"
      :key="idx"
      :to="link.to"
      >{{ link.label }}</Button
    >
  </div>
</template>

<script lang="ts">
import Vue from "vue";

import { Button } from "@/components/global";

export default Vue.extend({
  name: "tm-navbar",
  components: { Button },
  data() {
    return {
      links: [
        {
          to: "/",
          label: "Home",
        },
        {
          to: "/workingtimes/:userId",
          label: "Working Times",
        },
        {
          to: "/workingtime/:userId",
          label: "Working Time",
        },
        {
          to: "/workingtime/:userId/:workingTimeId",
          label: "Working Time",
        },
        {
          to: "/chartManager/:userId/",
          label: "Charts",
        },
      ],
    };
  },
});
</script>

<style lang="scss">
div.application {
  .navbar {
    height: 80px;
    width: 100vw;
    background: $layer-color;
    position: absolute;
    top: 0;
    left: 0;
    &-link {
      margin: 8px;
    }
  }
}
</style>
