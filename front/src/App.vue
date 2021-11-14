<template>
  <div id="app" class="application">
    <Navbar
      @toggle-signup-modal="() => (showSignUpModal = !showSignUpModal)"
      @toggle-signin-modal="() => (showSignInModal = !showSignInModal)"
    />
    <div class="application-view">
      <Modal
        v-if="showSignUpModal"
        @close-modal="() => (showSignUpModal = false)"
      >
        <SignUp @sign-up="() => (showSignUpModal = false)" />
      </Modal>
      <Modal
        v-else-if="showSignInModal || $route.path === '/login'"
        :hide-close="$route.path === '/login'"
        @close-modal="() => (showSignInModal = false)"
      >
        <SignIn @sign-in="() => (showSignInModal = false)" />
      </Modal>
      <div class="flex f-nowrap" v-if="isOnline">
        <div v-if="isDashboard" class="application-view-side flex f-upward">
          <router-view
            class="application-side"
            name="side"
            @update="() => loadWorkingTimes()"
          />
        </div>
        <div class="application-view-main flex f-column">
          <router-view
            class="application-header"
            name="header"
            @update="() => loadWorkingTimes()"
          />
          <router-view
            class="application-content"
            name="content"
            @update="() => loadWorkingTimes()"
          />
        </div>
      </div>
      <Offline v-else />
    </div>
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable @typescript-eslint/no-this-alias */
import mixins from "vue-typed-mixins";
import Vue from "vue";
import VueRouter, { Route, NavigationGuardNext } from "vue-router";
import moment from "moment";
import _ from "lodash";

import { store } from "@/store";
import { router } from "@/router";

import { API } from "@/mixins";
import { Navbar, Offline } from "@/components";
import { Modal } from "@/components/global";
import { SignUp, SignIn } from "@/components/forms";

Vue.use(VueRouter);

router.beforeEach((to: Route, from: Route, next: NavigationGuardNext<Vue>) => {
  if (to?.name !== "Login" && !localStorage.getItem("token")) next("/login");
  else next();
});

export default mixins(API).extend({
  name: "App",
  store,
  router,
  components: {
    Navbar,
    Modal,
    SignUp,
    SignIn,
    Offline,
  },
  data() {
    return {
      showSignUpModal: false,
      showSignInModal: false,
      workingTimes: {},
    };
  },
  created() {
    this.$store.dispatch("updateAuthStatus");
    this.loadWorkingTimes();
  },
  computed: {
    isOnline: function () {
      return navigator.onLine;
    },
    isDashboard: function () {
      const { $route: route } = this;
      const { path = [] } = route;
      return (
        path.includes("home" as never) || path.includes("overseer" as never)
      );
    },
  },
  watch: {
    showSignInModal(val: any) {
      if (val) this.showSignUpModal = false;
    },
    showSignUpModal(val: any) {
      if (val) this.showSignInModal = false;
    },
    // InternetConnection() {
    //   console.log({connectionStatus})
    // }
  },
  methods: {
    loadWorkingTimes: async function (): Promise<void> {
      const { $route: route } = this;
      const { userId } = route?.params || {};
      if (!+userId) return;
      const { data } = (await this.getWorkingTimes(+userId)) || {};
      // this.$set(
      //   this,
      //   "workingTimes",
      //   _.groupBy(_.orderBy(data || [], "start", "desc"), (data: any) =>
      //     moment(data?.start).format("DD/MM/YY")
      //   )
      // );
      this.$store.commit(
        "setWorkingTimes",
        _.groupBy(_.orderBy(data || [], "start", "desc"), (data: any) =>
          moment(data?.start).format("DD/MM/YY")
        )
      );
    },
  },
});
</script>

<style lang="scss">
html {
  background: $color-background;
  ::-webkit-scrollbar {
    display: none;
    width: 0px;
    background: transparent;
  }
}
div.application {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: $color-text;
  margin-top: 96px;

  &-view {
    margin: auto;
    padding: auto;

    &-side {
      flex-grow: 2;
      flex-shrink: 0;
      border-right: 1px solid $color-border;
      padding: 8px;
    }

    &-main {
      flex-grow: 3;
      flex-shrink: 1;
      padding: 8px;
    }
  }

  &-content {
    margin-top: 16px;
  }

  * {
    box-sizing: border-box;
  }

  // ANCHOR CSS Helpers - Flex
  .flex {
    display: flex;
    align-content: center;
    flex-wrap: wrap;
  }

  .f-column {
    flex-direction: column;
  }

  .f-nowrap {
    flex-wrap: nowrap;
  }

  .f-upward {
    align-content: flex-start;
  }

  .js-around {
    justify-content: space-around;
  }

  .js-between {
    justify-content: space-between;
  }

  .js-even {
    justify-content: space-evenly;
  }

  .js-center {
    justify-content: center;
  }

  .js-end {
    justify-content: end;
  }

  // ANCHOR CSS Helpers - Colors
  .shadow {
    box-shadow: 0px 0px 16px rgba(0, 0, 0, 0.25);
  }

  // ANCHOR CSS Helpers - Misc
  .pointer {
    cursor: pointer;
  }
}

* {
  box-sizing: border-box;
}
/* Remove extra left and right margins, due to padding in columns */

.row {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  width: 100%;
  margin: 20px 0;
}

.column {
  display: flex;
  flex-direction: row;
  width: 25%;
  padding: 0 16px;
}

@media screen and (max-width: 992px) {
  .column {
    width: 50%;
    margin-bottom: 20px;
  }
}
@media screen and (max-width: 600px) {
  .column {
    width: 100%;
  }
}
</style>
