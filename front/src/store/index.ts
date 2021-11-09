/* eslint-disable @typescript-eslint/no-explicit-any */
import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export const store = new Vuex.Store({
  state: {
    currentUser: {},
    token: "",
    isLoggedIn: false,
  },
  mutations: {
    setUser: function (state: any, value: any) {
      const { id, email, firstName, lastName, role = "user" } = value;
      state.currentUser = { id, firstName, lastName, email, role };
    },
    setToken: function (state: any, value: string) {
      state.token = value;
    },
    setIsLoggedIn: function (state: any, value: boolean) {
      state.isLoggedIn = value;
    },
  },
  actions: {
    updateAuthStatus: async function ({ commit }) {
      const token = localStorage.getItem("token");
      if (token) {
        commit("setToken", token);
        commit("setUser", {}); // TODO set active user here
        commit("setIsLoggedIn", true);
      } else {
        commit("setToken", "");
        commit("setUser", {});
        commit("setIsLoggedIn", false);
      }
    },
  },
});
