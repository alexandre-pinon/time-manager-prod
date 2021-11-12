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
import mixins from "vue-typed-mixins";
import { mapState } from "vuex";
import _ from "lodash";

import { CardForm, CardResult } from "@/components/forms";
import { API } from "@/mixins";

export default mixins(API).extend({
  name: "tm-working-time",
  props: {},
  data() {
    return {
      jsonData: {},
      cardParams: [
        {
          key: 1,
          title: "GET WORKINGTIME",
          action: "GET",
          apiCallEvent: "get-working-time",
          inputs: [
            {
              name: "userId",
              label: "User ID",
            },
            {
              name: "id",
              label: "WorkingTime ID",
            },
          ],
          eventHandler: "getWorkingTime",
        },
        {
          key: 2,
          title: "CREATE WORKINGTIME",
          action: "CREATE",
          apiCallEvent: "create-working-time",
          jsonData: "createdUser",
          inputs: [
            {
              name: "userId",
              label: "User ID",
            },
            {
              name: "start",
              label: "Start",
              type: "datetime-local",
            },
            {
              name: "end",
              label: "End",
              type: "datetime-local",
            },
          ],
          eventHandler: "createWorkingTime",
        },
        {
          key: 3,
          title: "UPDATE WORKINGTIME",
          action: "UPDATE",
          apiCallEvent: "update-working-time",
          jsonData: "updatedUser",
          inputs: [
            {
              name: "id",
              label: "WorkingTime ID",
            },
            {
              name: "start",
              label: "Start",
              type: "datetime-local",
            },
            {
              name: "end",
              label: "End",
              type: "datetime-local",
            },
          ],
          eventHandler: "updateWorkingTime",
        },
        {
          key: 4,
          title: "DELETE WORKINGTIME",
          action: "DELETE",
          apiCallEvent: "delete-working-time",
          inputs: [
            {
              name: "id",
              label: "WorkingTime ID",
            },
          ],
          eventHandler: "deleteWorkingTime",
        },
      ],
    };
  },
  components: {
    CardForm,
    CardResult,
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
    getWorkingTime: async function (formData: any) {
      const { userId, id } = formData;
      const { data } = (await this.getSingleWorkingTime(userId, id)) || {};
      this.jsonData = data;
      return data;
    },
    createWorkingTime: async function (formData: any) {
      const { userId, start, end } = formData;
      const { data } = (await this.createWorkingTime(userId, start, end)) || {};
      this.jsonData = data;
      return data;
    },
    updateWorkingTime: async function (formData: any) {
      const workingTime = _(formData).omitBy(_.isNil).omitBy(_.isEmpty).value();
      const { id } = workingTime;
      const { data } = (await this.updateWorkingTime(id, workingTime)) || {};
      this.jsonData = data;
      return data;
    },
    deleteWorkingTime: async function (formData: any) {
      const { id } = formData;
      await this.deleteWorkingTime(id);
      this.jsonData = { message: `Deleted Working Time n°${id}` };
    },
  },
});
</script>

<style lang="scss"></style>
