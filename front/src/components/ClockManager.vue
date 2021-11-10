<template>
  <div class="clock-manager flex f-column">
    Clock - {{ computedUserId || "No username loaded" }}
    <Card class="clock-manager-content">
      {{
        startDateTime
          ? startDateTime.format("DD/MM/YYYY HH:mm") +
            " - " +
            clockIn +
            " - " +
            computedTimer
          : "Chargement..."
      }}
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
import mixins from "vue-typed-mixins";
import moment, { Moment } from "moment";
import { mapState } from "vuex";

import { chainPromises } from "@/utils/helpers";
import { Card, Button } from "@/components/global";
import { API } from "@/mixins";

export default mixins(API).extend({
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
    computedUserId: function (): number {
      const { currentUser, $route: route } = this;
      const { id: currentUserId } = currentUser;
      const { userId } = route?.params || {};
      return currentUserId && +userId === +currentUserId ? currentUserId : 0;
    },
    computedTimer: function (): number {
      const { startDateTime } = this;
      return moment().diff(startDateTime, "seconds");
    },
    ...mapState(["currentUser"]),
  },
  created() {
    this.refresh();
  },
  methods: {
    refresh: async function (): Promise<void> {
      // this.clockIn = this.clockIn && !this.clockIn;
      // clearInterval(this.timer);
      // this.time = moment().startOf("date").format("HH:mm:ss");
      const { computedUserId } = this;
      let { data: clock } = (await this.getSingleClock(computedUserId)) || {};
      if (!clock)
        clock = (
          (await this.createClock(
            computedUserId,
            moment().format("YYYY-MM-DD HH:mm:ss"),
            false
          )) || {}
        )?.data;
      if (!clock) return;
      const { time, status } = clock;
      this.startDateTime = moment(time);
      this.clockIn = status;
    },
    clock: function (): void {
      // const { clockIn, time } = this;
      // this.clockIn = !clockIn;
      // this.startDateTime = moment();
      // if (clockIn) {
      //   this.timer = setInterval(() => {
      //     this.$set(
      //       this,
      //       "time",
      //       moment(time, "HH:mm:ss").add(1, "s").format("HH:mm:ss")
      //     );
      //   }, 1000);
      //   const tmpUserId = 1;
      //   this.startRecordTime(tmpUserId, time);
      // }
      const { computedUserId, startDateTime } = this;
      const [oldTime, newTime] = [startDateTime, moment()];
      this.clockIn = !this.clockIn;
      this.startDateTime = newTime;
      this.updateClock(computedUserId, {
        time: newTime.format("YYYY-MM-DD HH:mm:ss"),
        status: this.clockIn,
      });
      if (!this.clockIn)
        this.createWorkingTime(
          computedUserId,
          oldTime.format("YYYY-MM-DD HH:mm:ss"),
          newTime.format("YYYY-MM-DD HH:mm:ss")
        );
    },
    startRecordTime: async function (userId: number, time: string) {
      const clock = {
        status: true,
        time: moment(time).format("YYYY-MM-DD HH:mm:ss"),
      };

      const [clockData, workingTimeData] = await chainPromises([
        this.updateClock(userId, clock),
        this.createWorkingTime(userId, time, time),
      ]);
      this.currentWorkingTimeId = workingTimeData.id;
    },
    endRecordTime: async function (id: number, time: string) {
      const formatedTime = moment(time).format("YYYY-MM-DD HH:mm:ss");
      const clock = {
        status: false,
        time: formatedTime,
      };
      const workingTime = { end: formatedTime };

      const res = await chainPromises([
        this.updateClock(id, clock),
        this.updateWorkingTime(id, workingTime),
      ]);
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
