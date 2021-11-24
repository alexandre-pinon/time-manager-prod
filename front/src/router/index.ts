/* eslint-disable @typescript-eslint/no-explicit-any */
import VueRouter from "vue-router";

import {
  WorkingTimes,
  WorkingTime,
  ClockManager,
  ChartManager,
  User,
} from "@/components";

const routes: Array<any> = [
  // ANCHOR - Home redirect & auth
  {
    path: "/home",
    redirect: (to: Record<string, any>) => {
      const { params } = to;
      if (params?.userId) return "/home/:userId";
      else return "/login";
    },
  },
  {
    path: "/login",
    components: {},
    name: "Login",
  },
  // ANCHOR - Main pages
  {
    path: "/home/:userId",
    components: {
      header: ClockManager,
      side: WorkingTimes,
      content: ChartManager,
    },
    name: "Home",
  },
  {
    path: "/overseer",
    components: {
      // header: WorkingTime,
      side: User,
      content: ChartManager,
    },
    name: "Overseer",
  },
  // ANCHOR - Detailed views
  {
    path: "/workingtimes/:userId",
    components: { content: WorkingTimes },
    name: "WorkingTimes",
  },
  {
    path: "/workingtime/:userId",
    components: { content: WorkingTime },
    name: "WorkingTime",
  },
  {
    path: "/workingtime/:userId/:workingTimeId",
    components: { content: WorkingTime },
    name: "SingleWorkingTime",
  },
  {
    path: "/clock/:userId",
    components: { content: ClockManager },
    name: "Clock",
  },
  {
    path: "/chartmanager/:userId",
    components: { content: ChartManager },
    name: "Charts",
  },
  // ANCHOR - Offline & catch all
  // { path: "/error", components: { content: Offline }, name: "Offline" },
  {
    path: "*",
    redirect: "/home",
  },
];

export const router = new VueRouter({ routes, mode: "history" });
