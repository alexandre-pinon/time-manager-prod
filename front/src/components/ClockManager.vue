<template>
  <div>
    <h1>CLOCK MANAGER</h1>
    <h3>{{ time }}</h3>
    <button @click="clock()">{{ clockIn ? "STOP" : "START" }}</button>
    <button @click="refresh()" :disabled="!clockIn">REFRESH</button>
  </div>
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */

import api from "@/utils/api";
import { chainPromises } from "@/utils/helpers";
import moment, { Moment } from "moment";
import Vue from "vue";
import { mapState } from "vuex";

export default Vue.extend({
  name: "tm-clock-manager",
  props: {},
  data() {
    return {
      startDateTime: null as unknown as Moment,
      clockIn: false,
      time: moment().startOf("date").format("HH:mm:ss"),
      timer: 0,
      currentWorkingTimeId: 0,
    };
  },
  computed: {
    ...mapState(["currentUser"]),
  },
  methods: {
    refresh() {
      this.clockIn = this.clockIn && !this.clockIn;
      clearInterval(this.timer);
      this.time = moment().startOf("date").format("HH:mm:ss");
    },
    clock() {
      this.clockIn = !this.clockIn;
      this.startDateTime = moment();
      if (this.clockIn) {
        this.timer = setInterval(() => {
          this.$set(
            this,
            "time",
            moment(this.time, "HH:mm:ss").add(1, "s").format("HH:mm:ss")
          );
        }, 1000);
        const tmpUserId = 1;
        this.startRecordTime(tmpUserId, this.time);
      }
    },
    startRecordTime: async function (userId: number, time: string) {
      const clock = {
        status: true,
        time: moment(time).format("YYYY-MM-DD HH:mm:ss"),
      };

      const [clockData, workingTimeData] = await chainPromises([
        api.updateClock(userId, clock),
        api.createWorkingTime(userId, time, time),
      ]);
      this.currentWorkingTimeId = workingTimeData.id;
      console.log(clockData, workingTimeData, time);
    },
    endRecordTime: async function (id: number, time: string) {
      const formatedTime = moment(time).format("YYYY-MM-DD HH:mm:ss");
      const clock = {
        status: false,
        time: formatedTime,
      };
      const workingTime = { end: formatedTime };

      const res = await chainPromises([
        api.updateClock(id, clock),
        api.updateWorkingTime(id, workingTime),
      ]);
      console.log(res);
    },
  },
});
</script>