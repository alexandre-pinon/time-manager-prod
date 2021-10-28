<template>
  <div id="app" class="application">
    <img alt="Vue logo" src="./assets/logo.png" />
    <User />
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import VueRouter from "vue-router";
import Vuex from "vuex";

import { store } from "@/store";
import { router } from "@/router";

import { User } from "@/components";

Vue.use(Vuex);
Vue.use(VueRouter);

export default Vue.extend({
  name: "App",
  store,
  router,
  components: {
    User,
  },
});
</script>

<style lang="scss">
div.application {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
