/* eslint-disable @typescript-eslint/no-explicit-any */
import VueRouter from "vue-router";

import {
  WorkingTimes,
  WorkingTime,
  ClockManager,
  ChartManager,
} from "@/components";

const routes: Array<any> = [
  { path: "/workingtimes/:userId", component: WorkingTimes },
  { path: "/workingtime/:userId/", component: WorkingTime },
  { path: "/workingtime/:userId/:workingTimeId", component: WorkingTime },
  { path: "/clock/:username", component: ClockManager },
  { path: "/chartmanager/:userId", component: ChartManager },
];

export const router = new VueRouter({ routes });
