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

import Vue from "vue";
import { mapState } from "vuex";
import api from "@/utils/api";
import { CardForm, CardResult } from "@/components";

export default Vue.extend({
  name: "tm-user",
  props: {},
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
              name: "userID",
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
              name: "userID",
              label: "User ID",
            },
            {
              name: "username",
              label: "Username",
            },
            {
              name: "email",
              label: "Email",
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
              name: "userID",
              label: "User ID",
            },
          ],
          eventHandler: "deleteUser",
        },
      ],
    };
  },
  components: {
    CardForm,
    CardResult,
  },
  filters: {
    pretty: function (value: string) {
      return JSON.stringify(value, null, 2);
    },
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
    getUser: async function ({ userID: id }: { userID: number }) {
      const { data } = (await api.getUser(id)) || {};
      if (data) this.$store.commit("setUser", data);
      this.jsonData = data;
      return data;
    },
    createUser: async function (username: string, email: string) {
      const { data } = (await api.createUser(username, email)) || {};
      this.jsonData = data;
      return data;
    },
    updateUser: async function (id: number, user: any) {
      user = Object.fromEntries(Object.entries(user).filter(([_, v]) => !!v));
      const { data } = (await api.updateUser(id, user)) || {};
      this.jsonData = data;
      return data;
    },
    deleteUser: async function (id: number) {
      const { currentUser } = this;
      await api.deleteUser(id);
      if (id === currentUser?.id) this.$store.commit("setUser", {});
      this.jsonData = { message: "OK" };
    },
  },
});
</script>

<style lang="scss">
* {
  box-sizing: border-box;
}
/* Remove extra left and right margins, due to padding in columns */

.container {
  margin: auto;
  width: 80%;
}

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

@media screen and (max-width: 600px) {
  .column {
    width: 100%;
    display: block;
    margin-bottom: 20px;
  }
}

.card {
  &-form,
  &-result {
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2); /* this adds the "card" effect */
    padding: 16px;
    text-align: center;
    background-color: #f7f7f7;
    transition: 0.3s;
    display: flex;
    flex-direction: column;
    width: 100%;

    &:hover {
      box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
    }
  }

  &-result {
    margin: 0 16px;
  }
}

.flexible {
  flex-grow: 1;
}

input[type="text"],
input[type="email"] {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

button[type="button"] {
  background-color: #4caf50;
  color: white;
  width: 100%;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;

  &:hover {
    background-color: #45a049;
  }

  &[disabled="disabled"] {
    background-color: rgb(216, 216, 216);
    color: grey;

    &:hover {
      background-color: rgb(216, 216, 216);
    }
  }
}

pre {
  white-space: pre-wrap;
  text-align: left;
  font-size: large;
  color: #2c3e50;
  padding: 0 16px;
}
</style>
