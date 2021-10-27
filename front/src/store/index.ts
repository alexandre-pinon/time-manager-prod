/* eslint-disable @typescript-eslint/no-explicit-any */
import Vuex from "vuex";

export const store = new Vuex.Store({
  state: {
    currentUser: {},
  },
  mutations: {
    setUser: function (state: any, value: any) {
      const { id, username, email } = value;
      state.currentUser = { id, username, email };
    },
  },
});
