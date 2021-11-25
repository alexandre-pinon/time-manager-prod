<template>
  <div
    v-if="isMinified && isLoggedIn"
    class="navbar navbar-minified shadow flex js-center"
  >
    <Button
      class="navbar-shortcut"
      icon
      round
      @click="() => (isMinified = false)"
    >
      <MenuIcon />
    </Button>
  </div>
  <div v-else class="navbar navbar-full flex js-between shadow" id="navigation">
    <div class="navbar-links flex js-center">
      <Button
        v-if="isLoggedIn"
        class="navbar-link"
        transparent
        :to="'/home/' + (currentUser || {}).id || 0"
      >
        Accueil
      </Button>
      <Button
        v-if="isAdmin || isManager"
        class="navbar-link"
        transparent
        to="/overseer"
      >
        Supervision
      </Button>
    </div>
    <div class="navbar-extras flex">
      <h2 v-if="currentUser.firstName" class="navbar-hello">
        Bonjour, {{ currentUser.firstName }}
      </h2>
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
        v-if="isLoggedIn"
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
      ];
    },
    ...mapState(["currentUser", "isLoggedIn", "isAdmin", "isManager"]),
  },
  methods: {
    signOut: async function () {
      await this.$store.dispatch("removeAuthStatus");
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
      padding-right: 30px;
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
    &-hello {
      margin-right: 16px;
    }
  }
}
@media screen and (max-width: 600px) {
  div.application {
    .navbar {
      position: absolute;
      top: 0;
      &-full {
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
      &-hello {
        display: none;
      }
    }
  }
  #navigation {
    flex-flow: nowrap;
  }
}
@media screen and (min-width: 600px) and (max-width: 750px) {
  div.application {
    .navbar {
      position: absolute;
      top: 0;
      &-full {
      padding-left: 30px;
      padding-right: 30px;
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
      &-hello {
        display: none;
      }
    }
  }
  #navigation {
    flex-flow: nowrap;
  }
}
</style>
