/* eslint-disable @typescript-eslint/no-explicit-any */
import VueRouter from "vue-router";

import {
  WorkingTimes,
  WorkingTime,
  ClockManager,
  ChartManager,
  User,
  Offline
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
      side: ClockManager,
      content: ChartManager,
    },
    name: "Home",
  },
  {
    path: "/overseer",
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
  // ANCHOR - Catch all
  {
    path: "*",
    redirect: "/home",
  },
  { path: "/error", component: Offline, name: "offline mode"}
];

export const router = new VueRouter({ routes, mode: "history" });
