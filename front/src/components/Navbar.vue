<template>
  <div v-if="isMinified" class="navbar navbar-minified shadow flex js-center">
    <Button
      class="navbar-shortcut"
      icon
      round
      @click="() => (isMinified = false)"
    >
      <MenuIcon />
    </Button>
  </div>
  <div v-else class="navbar navbar-full flex js-between shadow">
    <div class="navbar-links flex js-center">
      <Button
        v-for="(link, idx) in links"
        class="navbar-link"
        transparent
        :key="idx"
        :to="link.to"
        >{{ link.label }}</Button
      >
    </div>
    <div class="navbar-extras flex">
      <Button
        class="navbar-link"
        icon
        @click="() => $emit('toggle-user-modal')"
      >
        <UserIcon />
      </Button>
      <Button
        class="navbar-link"
        negative
        icon
        @click="() => (isMinified = true)"
      >
        <XIcon />
      </Button>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from "vue";

import { UserIcon, MenuIcon, XIcon } from "vue-feather-icons";
import { Button } from "@/components/global";

export default Vue.extend({
  name: "tm-navbar",
  components: { Button, UserIcon, MenuIcon, XIcon },
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
      isMinified: true,
    };
  },
});
</script>

<style lang="scss">
div.application {
  .navbar {
    position: absolute;
    top: 0;
    &-full {
      padding-left: 80px;
      padding-right: 80px;
      top: 0;
      height: 80px;
      width: 100vw;
    }
    &-minified {
      right: 80px;
      padding: 16px;
      border-bottom-left-radius: 50%;
      border-bottom-right-radius: 50%;
    }
    &-link {
      margin: 8px;
    }
  }
}
</style>
