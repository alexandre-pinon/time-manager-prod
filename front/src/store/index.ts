/* eslint-disable @typescript-eslint/no-explicit-any */
import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export const store = new Vuex.Store({
  state: {
    currentUser: {},
    token: "",
  },
  mutations: {
    setUser: function (state: any, value: any) {
      const {
        id,
        username,
        firstname,
        lastname,
        role = "USER",
        team = "",
      } = value;
      state.currentUser = { id, username, firstname, lastname, role, team };
    },
    setToken: function (state: any, value: string) {
      state.token = value;
    },
  },
});
