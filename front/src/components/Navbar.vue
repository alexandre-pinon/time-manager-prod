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
        v-for="(link, idx) in computedLinks"
        class="navbar-link"
        transparent
        :key="idx"
        :to="link.to"
        >{{ link.label }}</Button
      >
    </div>
    <div class="navbar-extras flex">
      <Button
        v-if="!isLoggedIn"
        class="navbar-link"
        icon
        @click="() => $emit('toggle-signin-modal')"
      >
        <UserIcon />
      </Button>
      <Button
        v-if="!isLoggedIn"
        class="navbar-link"
        icon
        @click="() => $emit('toggle-signup-modal')"
      >
        <UserPlusIcon />
      </Button>
      <Button
        v-if="isLoggedIn"
        class="navbar-link"
        negative
        icon
        @click="() => signOut()"
      >
        <UserXIcon />
      </Button>
      <Button
        class="navbar-link"
        transparent
        icon
        @click="() => (isMinified = true)"
      >
        <XIcon />
      </Button>
    </div>
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */
import Vue from "vue";

import { mapState } from "vuex";

import {
  UserIcon,
  UserXIcon,
  UserPlusIcon,
  MenuIcon,
  XIcon,
} from "vue-feather-icons";
import { Button } from "@/components/global";

export default Vue.extend({
  name: "tm-navbar",
  components: { Button, UserIcon, UserPlusIcon, UserXIcon, MenuIcon, XIcon },
  data() {
    return {
      isMinified: localStorage.getItem("token"),
    };
  },
  computed: {
    computedLinks: function (): Array<Record<string, any>> {
      const { id: userId } = this?.currentUser || {};
      return [
        {
          to: `/home/${userId}`,
          label: "Home",
        },
        // {
        //   to: `/workingtimes/${userId}`,
        //   label: "Working Times",
        // },
        // {
        //   to: `/workingtime/${userId}`,
        //   label: "Working Time",
        // },
        // {
        //   to: `/workingtime/${userId}/:workingTimeId`,
        //   label: "Working Time",
        // },
        {
          to: `/clock/${userId}`,
          label: "Clock",
        },
        // {
        //   to: `/chartmanager/${userId}`,
        //   label: "Charts",
        // },
      ];
    },
    ...mapState(["currentUser", "isLoggedIn"]),
  },
  methods: {
    signOut: function () {
      localStorage.setItem("token", "");
      this.$store.dispatch("updateAuthStatus");
      this.$router.push("/login");
    },
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
