<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */
import Vue from "vue";
import axios from "axios";
import _ from "lodash";
import moment from "moment";

import { mapState } from "vuex";

import { handleError } from "@/utils/helpers";

export default Vue.extend({
  name: "tm-api-mixin",
  computed: {
    computedUrl: function (): string {
      const { url, port } = this;
      return `${url}:${port}/api`;
    },
    computedHeaders: function (): Record<string, any> {
      const { token } = this;
      return { headers: { Authorization: token } };
    },
    ...mapState(["currentUser", "token", "url", "port"]),
  },
  methods: {
    // ANCHOR - Auth routes
    async signIn(email: string, password: string): Promise<any> {
      const { computedUrl } = this;
      console.log("signIn");
      return await axios
        .post(`${computedUrl}/users/sign_in`, { user: { email, password } })
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("signIn", err));
    },
    async signUp(
      email: string,
      firstName: string,
      lastName: string,
      password: string,
      passwordConfirm: string
    ): Promise<any> {
      const { computedUrl } = this;
      console.log("signUp");
      return await axios
        .post(`${computedUrl}/users/sign_up`, {
          user: {
            email,
            password,
            password_confirmation: passwordConfirm,
            first_name: firstName,
            last_name: lastName,
            role: "user",
          },
        })
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("signUp", err));
    },

    // ANCHOR - User routes
    async getAllUsers(): Promise<any> {
      const { computedHeaders, computedUrl } = this;
      console.log("getUsers");
      return await axios
        .get(`${computedUrl}/users`, computedHeaders)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("getUsers", err));
    },
    async getSingleUser(id: number): Promise<any> {
      const { computedHeaders, computedUrl } = this;
      console.log("getSingleUser : ", id);
      return await axios
        .get(`${computedUrl}/users/${id}`, computedHeaders)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("getSingleUser", err));
    },
    async createUser(username: string, email: string): Promise<any> {
      const { computedHeaders, computedUrl } = this;
      console.log("createUser : ", username, email);
      return await axios
        .post(
          `${computedUrl}/users`,
          { user: { username, email } },
          computedHeaders
        )
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("createUser", err));
    },
    async updateUser(id: number, user: any): Promise<any> {
      const { computedHeaders, computedUrl } = this;
      console.log("updateUser : ", id, user);
      return await axios
        .put(`${computedUrl}/users/${id}`, { user }, computedHeaders)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("updateUser", err));
    },
    async deleteUser(id: number): Promise<any> {
      const { computedHeaders, computedUrl } = this;
      console.log("deleteUser : ", id);
      return await axios
        .delete(`${computedUrl}/users/${id}`, computedHeaders)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("deleteUser", err));
    },
    async updateRole(id: number, role: string): Promise<any> {
      const { computedHeaders, computedUrl } = this;
      console.log("updateRole : ", id);
      if (!["user", "manager", "admin"].includes(role)) return;
      return await axios
        .put(
          `${computedUrl}/users/set_role/${id}`,
          { user: { role } },
          computedHeaders
        )
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("updateRole", err));
    },

    // ANCHOR - Working times routes
    async getWorkingTimes(
      userId: number,
      start: any = undefined,
      end: any = undefined
    ): Promise<any> {
      const { computedHeaders, computedUrl } = this;
      console.log("getWorkingTimes : ", userId, start, end);
      // params here is directly stringified as needed by the API
      // > _.omitBy(...) removes all values from an object for which the callback returns true
      //    * in this case, it removes start, end, or both depending on which is undefined
      // > _.map(...) is similar to the native JS one and returns an array, but can be applied like here on an object
      //    * in this case, it takes the key/values left in {start, end} by the omitBy and maps them to a properly formatted query parameter
      const params =
        start || end
          ? "?" +
            _.map(
              _.omitBy({ start, end }, _.isUndefined),
              (val: any, key: any) =>
                `${key}=${moment(val).format("YYYY-MM-DD")}`
            ).join("&")
          : "";
      return await axios
        .get(`${computedUrl}/workingtimes/${userId}${params}`, computedHeaders)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("getWorkingTimes", err));
    },
    async getSingleWorkingTime(userId: number, id: number): Promise<any> {
      const { computedHeaders, computedUrl } = this;
      console.log("getSingleWorkingTime : ", userId, id);
      return await axios
        .get(`${computedUrl}/workingtimes/${userId}/${id}`, computedHeaders)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("getSingleWorkingTime", err));
    },
    async createWorkingTime(
      userId: number,
      start: string,
      end: string
    ): Promise<any> {
      const { computedHeaders, computedUrl } = this;
      console.log("createWorkingTime : ", userId, start, end);
      return await axios
        .post(
          `${computedUrl}/workingtimes/${userId}`,
          {
            working_time: {
              start: moment(start).format("YYYY-MM-DD HH:mm:ss"),
              end: moment(end).format("YYYY-MM-DD HH:mm:ss"),
            },
          },
          computedHeaders
        )
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("createWorkingTime", err));
    },
    async updateWorkingTime(id: number, workingTime: any): Promise<any> {
      const { computedHeaders, computedUrl } = this;
      console.log("updateWorkingTime : ", id, workingTime);
      return await axios
        .put(
          `${computedUrl}/workingtimes/${id}`,
          { working_time: workingTime },
          computedHeaders
        )
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("updateWorkingTime", err));
    },
    async deleteWorkingTime(id: number): Promise<any> {
      const { computedHeaders, computedUrl } = this;
      console.log("deleteWorkingTime : ", id);
      return await axios
        .delete(`${computedUrl}/workingtimes/${id}`, computedHeaders)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("deleteWorkingTime", err));
    },

    // ANCHOR - Clock routes
    async getSingleClock(userId: number): Promise<any> {
      const { computedHeaders, computedUrl } = this;
      console.log("getSingleClock : ", userId);
      return await axios
        .get(`${computedUrl}/clocks/${userId}`, computedHeaders)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("getSingleClock", err));
    },
    async createClock(
      userId: number,
      time: string,
      status: boolean
    ): Promise<any> {
      const { computedHeaders, computedUrl } = this;
      console.log("createClock : ", userId, time, status);
      return await axios
        .post(
          `${computedUrl}/clocks/${userId}`,
          {
            clock: { time: moment(time).format("YYYY-MM-DD HH:mm:ss"), status },
          },
          computedHeaders
        )
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("createClock", err));
    },
    async updateClock(userId: number, clock: any): Promise<any> {
      const { computedHeaders, computedUrl } = this;
      console.log("updateClock : ", userId, clock);
      return await axios
        .put(`${computedUrl}/clocks/${userId}`, { clock }, computedHeaders)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("updateClock", err));
    },

    // ANCHOR - Teams routes
    async getAllTeams(): Promise<void> {
      const { computedHeaders, computedUrl } = this;
      console.log("getTeams");
      return await axios
        .get(`${computedUrl}/teams`, computedHeaders)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("getTeams", err));
    },
    async getSingleTeam(id: number): Promise<void> {
      const { computedHeaders, computedUrl } = this;
      console.log("getSingleTeam : ", id);
      return await axios
        .get(`${computedUrl}/teams/${id}`, computedHeaders)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("getSingleTeam", err));
    },
    async getUserTeams(userId: number): Promise<void> {
      const { computedHeaders, computedUrl } = this;
      console.log("getUserTeams : ", userId);
      return await axios
        .get(`${computedUrl}/teams/users/${userId}`, computedHeaders)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("getUserTeams", err));
    },
    async createTeam(name: string): Promise<any> {
      const { computedHeaders, computedUrl } = this;
      console.log("createTeam : ", name);
      return await axios
        .post(
          `${computedUrl}/teams`,
          {
            team: {
              name,
            },
          },
          computedHeaders
        )
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("createTeam", err));
    },
    async updateTeam(id: number, team: any): Promise<any> {
      const { computedHeaders, computedUrl } = this;
      console.log("updateTeam : ", id, team);
      return await axios
        .put(`${computedUrl}/teams/${id}`, { team }, computedHeaders)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("updateTeam", err));
    },
    async deleteTeam(id: number): Promise<any> {
      const { computedHeaders, computedUrl } = this;
      console.log("deleteTeam : ", id);
      return await axios
        .delete(`${computedUrl}/teams/${id}`, computedHeaders)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("deleteTeam", err));
    },
  },
});
</script>
