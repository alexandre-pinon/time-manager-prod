import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

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