<template>
  <div></div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */

import Vue from "vue";
import { mapState } from "vuex";
import api from "@/utils/api";

export default Vue.extend({
  name: "tm-user",
  props: {},
  data() {
    return {};
  },
  computed: {
    ...mapState(["currentUser"]),
  },
  methods: {
    createUser: async function (username: string, email: string) {
      const { data } = (await api.createUser(username, email)) || {};
      return data;
    },
    updateUser: async function (id: number, user: any) {
      const { data } = (await api.updateUser(id, user)) || {};
      return data;
    },
    deleteUser: async function (id: number) {
      const { currentUser } = this;
      await api.deleteUser(id);
      if (id === currentUser?.id) this.$store.commit("setUser", {});
    },
    getUser: async function (id: number) {
      const { data } = (await api.getUser(id)) || {};
      if (data) this.$store.commit("setUser", data);
      return data;
    },
  },
});
</script>

<style lang="scss"></style>
