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
        ? `https://${config?.API_HOST || "localhost"}`
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
    updateAuthStatus: async function ({ dispatch, commit, state }, payload) {
      const {
        token,
        id,
        role: localRole,
      } = payload || {
        token: localStorage.getItem("token"),
        id: +(localStorage.getItem("id") || 0),
        role: localStorage.getItem("role") || "user",
      };
      console.log({ token, id, localRole, payload });
      if (!token || !id) {
        await dispatch("removeAuthStatus");
        return;
      }
      const { data: user } = await axios
        .get(`${state.url}:${state.port}/api/users/${id}`, {
          headers: { Authorization: token },
        })
        .then((result: any) => result?.data)
        .catch(async (err: any) => {
          console.log("STORE INIT ERROR - ", err);
          await dispatch("removeAuthStatus");
          return;
        });
      if (+user?.id === +id && user?.role) {
        const { role = localRole } = user;
        localStorage.setItem("token", token);
        localStorage.setItem("id", id);
        localStorage.setItem("role", role);
        commit("setToken", token);
        commit("setUser", user);
        commit("setIsLoggedIn", true);
        commit("setIsAdmin", role === "admin");
        commit("setIsManager", role === "manager");
      } else await dispatch("removeAuthStatus");
    },
    removeAuthStatus: async function ({ commit }) {
      localStorage.setItem("token", "");
      localStorage.setItem("id", "");
      localStorage.setItem("role", "");
      commit("setToken", "");
      commit("setUser", {});
      commit("setWorkingTimes", {});
      commit("setIsLoggedIn", false);
      commit("setIsAdmin", false);
      commit("setIsManager", false);
    },
  },
});
