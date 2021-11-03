/* eslint-disable @typescript-eslint/no-explicit-any */
import VueRouter from "vue-router";

import {
  Home,
  WorkingTimes,
  WorkingTime,
  //   ClockManager,
  ChartManager,
} from "@/components";

const routes: Array<any> = [
  {
    path: "/",
    component: Home,
    name: "Home",
  },
  {
    path: "/workingtimes/:userId",
    component: WorkingTimes,
    name: "WorkingTimes",
  },
  {
    path: "/workingtime/:userId",
    component: WorkingTime,
    name: "UserWorkingTime",
  },
  {
    path: "/workingtime/:userId/:workingTimeId",
    component: WorkingTime,
    name: "WorkingTime",
  },
  // { path: "/clock/:username", component: ClockManager, name: "Clock" },
  { path: "/chartmanager/:userId", component: ChartManager, name: "Charts" },
];

export const router = new VueRouter({ routes });
