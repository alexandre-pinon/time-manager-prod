<template>
  <div class="clock-manager flex f-column">
    Clock - {{ computedUsername || "No username loaded" }}
    <Card class="clock-manager-content">
      {{ startDateTime + " - il y a " + computedTimer }}
      <Button @click="() => clock()"> Changer de statut </Button>
    </Card>
  </div>
  <!-- <div>
    <h1>CLOCK MANAGER</h1>
    <h3>{{ time }}</h3>
    <button @click="clock()">{{ clockIn ? "STOP" : "START" }}</button>
    <button @click="refresh()" :disabled="!clockIn">REFRESH</button>
  </div> -->
</template>

<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */
import Vue from "vue";
import moment, { Moment } from "moment";

import { mapState } from "vuex";

import api from "@/utils/api";
import { chainPromises } from "@/utils/helpers";
import { Card, Button } from "@/components/global";

export default Vue.extend({
  name: "tm-clock-manager",
  components: { Card, Button },
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
    computedUsername: function (): string {
      const { currentUser, $route: route } = this;
      const { username: currentUsername } = currentUser;
      const { username } = route?.params || {};
      return currentUsername && username === currentUsername
        ? currentUsername
        : "";
    },
    computedUserId: function (): number {
      const { currentUser, computedUsername } = this;
      const { currentUserId, currentUsername } = currentUser;
      return currentUsername === computedUsername ? +currentUserId : 0;
    },
    computedTimer: function (): number {
      return 101;
    },
    ...mapState(["currentUser"]),
  },
  created() {
    this.refresh();
  },
  methods: {
    refresh: async function (): Promise<void> {
      this.clockIn = this.clockIn && !this.clockIn;
      clearInterval(this.timer);
      this.time = moment().startOf("date").format("HH:mm:ss");
    },
    clock: function (): void {
      const { clockIn, time } = this;
      this.clockIn = !clockIn;
      this.startDateTime = moment();
      if (clockIn) {
        this.timer = setInterval(() => {
          this.$set(
            this,
            "time",
            moment(time, "HH:mm:ss").add(1, "s").format("HH:mm:ss")
          );
        }, 1000);
        const tmpUserId = 1;
        this.startRecordTime(tmpUserId, time);
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

<style lang="scss">
div.application {
  .clock-manager {
    &-content {
      margin-top: 16px;
    }
  }
}
</style>