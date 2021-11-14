/* eslint-disable @typescript-eslint/no-explicit-any */
import Vue from "vue";
import Vuex from "vuex";
import axios from "axios";

import config from "@/config.json";

Vue.use(Vuex);

export const store = new Vuex.Store({
  state: {
    currentUser: {},
    token: "",
    isLoggedIn: false,
    isAdmin: false,
    isManager: false,
    workingTimes: {},
    url:
      process?.env?.NODE_ENV === "production"
        ? `http://${config?.API_HOST || "localhost"}`
        : "http://localhost",
    port:
      process?.env?.NODE_ENV === "production"
        ? config?.API_PORT || "4000"
        : "4000",
  },
  mutations: {
    setUser: function (state: any, value: any) {
      const {
        id,
        email,
        first_name: firstName,
        last_name: lastName,
        role = "user",
      } = value;
      state.currentUser = { id, firstName, lastName, email, role };
    },
    setToken: function (state: any, value: string) {
      state.token = value;
    },
    setIsLoggedIn: function (state: any, value: boolean) {
      state.isLoggedIn = value;
    },
    setIsAdmin: function (state: any, value: boolean) {
      state.isAdmin = value;
    },
    setIsManager: function (state: any, value: boolean) {
      state.isManager = value;
    },
    setWorkingTimes: function (state: any, value: Record<string, any>) {
      state.workingTimes = value;
    },
  },
  actions: {
    updateAuthStatus: async function ({ commit, state }, payload) {
      const { token, id } = payload || {
        token: localStorage.getItem("token"),
        id: +(localStorage.getItem("id") || 0),
      };
      if (token && id) {
        const { data: user } = await axios
          .get(`${state.url}:${state.port}/api/users/${id}`, {
            headers: { Authorization: token },
          })
          .then((result: any) => result?.data);
        if (!user?.role && !user?.id) return;
        const { role } = user;
        localStorage.setItem("token", token);
        localStorage.setItem("id", id);
        commit("setToken", token);
        commit("setUser", user);
        commit("setIsLoggedIn", true);
        commit("setIsAdmin", role === "admin");
        commit("setIsManager", role === "manager");
      } else {
        localStorage.setItem("token", "");
        localStorage.setItem("id", "");
        commit("setToken", "");
        commit("setUser", {});
        commit("setIsLoggedIn", false);
        commit("setIsAdmin", false);
        commit("setIsManager", false);
      }
    },
    removeAuthStatus: async function ({ dispatch }) {
      localStorage.setItem("token", "");
      localStorage.setItem("id", "");
      await dispatch("updateAuthStatus");
    },
  },
});
