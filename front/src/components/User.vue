<template>
  <div class="container">
    <div class="row">
      <div class="column" v-for="param in cardParams" :key="param.key">
        <CardForm
          :title="param.title"
          :action="param.action"
          :apiCallEvent="param.apiCallEvent"
          :inputs="param.inputs"
          @api-call="(formData) => handleCall(param, formData)"
        />
      </div>
    </div>
    <div class="row">
      <CardResult :jsonData="jsonData" />
    </div>
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable @typescript-eslint/no-this-alias */
/* eslint-disable @typescript-eslint/no-empty-function */
import Vue from "vue";
import _ from "lodash";

import { mapState } from "vuex";

import api from "@/utils/api";
import { CardForm, CardResult } from "@/components/forms";

export default Vue.extend({
  name: "tm-user",
  components: {
    CardForm,
    CardResult,
  },
  data() {
    return {
      jsonData: {},
      cardParams: [
        {
          key: 1,
          title: "GET USER",
          action: "GET",
          apiCallEvent: "get-user",
          inputs: [
            {
              name: "userId",
              label: "User ID",
            },
          ],
          eventHandler: "getUser",
        },
        {
          key: 2,
          title: "CREATE USER",
          action: "CREATE",
          apiCallEvent: "create-user",
          jsonData: "createdUser",
          inputs: [
            {
              name: "username",
              label: "Username",
            },
            {
              name: "email",
              label: "Email",
              type: "email",
            },
          ],
          eventHandler: "createUser",
        },
        {
          key: 3,
          title: "UPDATE USER",
          action: "UPDATE",
          apiCallEvent: "update-user",
          jsonData: "updatedUser",
          inputs: [
            {
              name: "userId",
              label: "User ID",
            },
            {
              name: "username",
              label: "Username",
            },
            {
              name: "email",
              label: "Email",
              type: "email",
            },
          ],
          eventHandler: "updateUser",
        },
        {
          key: 4,
          title: "DELETE USER",
          action: "DELETE",
          apiCallEvent: "delete-user",
          inputs: [
            {
              name: "userId",
              label: "User ID",
            },
          ],
          eventHandler: "deleteUser",
        },
      ],
    };
  },
  computed: {
    ...mapState(["currentUser"]),
  },
  methods: {
    handleCall: async function (param: any, formData: any) {
      const { eventHandler } = param;
      // Rebinds this to the component => was lost because of the arrow function in template!
      const vm: any = this;
      await (vm[eventHandler] || (() => {}))(formData); // empty func just to be safe
    },
    getUser: async function (formData: any) {
      const { userId: id } = formData;
      const { data } = (await api.getUser(id)) || {};
      if (data) this.$store.commit("setUser", data);
      this.jsonData = data;
      return data;
    },
    createUser: async function (formData: any) {
      const { username, email } = formData;
      const { data } = (await api.createUser(username, email)) || {};
      this.jsonData = data;
      return data;
    },
    updateUser: async function (formData: any) {
      const user = _(formData).omitBy(_.isNil).omitBy(_.isEmpty).value();
      const { userId: id } = user;
      const { data } = (await api.updateUser(id, user)) || {};
      this.jsonData = data;
      return data;
    },
    deleteUser: async function (formData: any) {
      const { userId: id } = formData;
      const { currentUser } = this;
      await api.deleteUser(id);
      if (id === currentUser?.id) this.$store.commit("setUser", {});
      this.jsonData = { message: `Deleted user n°${id}` };
    },
  },
});
</script>

<style lang="scss"></style>
