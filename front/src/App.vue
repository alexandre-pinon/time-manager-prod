<template>
  <div id="app" class="application">
    <Navbar @toggle-user-modal="() => (showUserModal = !showUserModal)" />
    <div class="application-view">
      <Modal
        v-show="showUserModal"
        @close-modal="() => (showUserModal = false)"
      >
        <User />
      </Modal>
      <router-view />
    </div>
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable @typescript-eslint/no-this-alias */
import Vue from "vue";
import VueRouter from "vue-router";

import { store } from "@/store";
import { router } from "@/router";

import { Navbar, User } from "@/components";
import { Modal } from "@/components/global";

Vue.use(VueRouter);

export default Vue.extend({
  name: "App",
  store,
  router,
  components: {
    User,
    Navbar,
    Modal,
  },
  data() {
    return {
      showUserModal: false,
    };
  },
  watch: {
    showUserModal(val: any) {
      console.log({ show: val });
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
