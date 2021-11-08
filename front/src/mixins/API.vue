<script lang="ts">
/* eslint-disable @typescript-eslint/no-explicit-any */
import Vue from "vue";
import axios from "axios";
import _ from "lodash";
import moment from "moment";

import { mapState } from "vuex";

import { handleError } from "@/utils/helpers";
import config from "@/config.json";

export default Vue.extend({
  name: "tm-api-mixin",
  data() {
    return {
      url: "http://localhost",
      port: "4000",
    };
  },
  computed: {
    computedUrl: function (): string {
      const { url, port } = this;
      return `${url}:${port}/api`;
    },
    computedHeaders: function (): Record<string, any> {
      const { token } = this;
      return { headers: { Authorization: token } };
    },
    ...mapState(["currentUser", "token"]),
  },
  created() {
    if (process?.env?.NODE_ENV === "production") {
      this.url = `http://${config?.API_HOST || "localhost"}`;
      this.port = config?.API_PORT || "4000";
    }
  },
  methods: {
    // ANCHOR - Auth routes
    async signIn(email: string, password: string): Promise<any> {
      const { computedUrl } = this;
      console.log("signIn");
      const result = axios
        .post(`${computedUrl}/users/sign_in`, { user: { email, password } })
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("signIn", err));
      console.log({ result });
    },
    async signUp(
      firstName: string,
      lastName: string,
      email: string,
      password: string,
      passwordConfirm: string
    ): Promise<any> {
      const { computedUrl } = this;
      console.log("signUp");
      const result = axios
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
      console.log({ result });
    },

    // ANCHOR - User routes
    async getAllUsers(): Promise<any> {
      const { computedUrl } = this;
      console.log("getUsers");
      return await axios
        .get(`${computedUrl}/users`)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("getUsers", err));
    },
    async getSingleUser(id: number): Promise<any> {
      const { computedUrl } = this;
      console.log("getSingleUser : ", id);
      return await axios
        .get(`${computedUrl}/users/${id}`)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("getSingleUser", err));
    },
    async createUser(username: string, email: string): Promise<any> {
      const { computedUrl } = this;
      console.log("createUser : ", username, email);
      return await axios
        .post(`${computedUrl}/users`, { user: { username, email } })
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("createUser", err));
    },
    async updateUser(id: number, user: any): Promise<any> {
      const { computedUrl } = this;
      console.log("updateUser : ", id, user);
      return await axios
        .put(`${computedUrl}/users/${id}`, { user })
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("updateUser", err));
    },
    async deleteUser(id: number): Promise<any> {
      const { computedUrl } = this;
      console.log("deleteUser : ", id);
      return await axios
        .delete(`${computedUrl}/users/${id}`)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("deleteUser", err));
    },

    // ANCHOR - Working times routes
    async getWorkingTimes(
      userId: number,
      start: any = undefined,
      end: any = undefined
    ): Promise<any> {
      const { computedUrl } = this;
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
        .get(`${computedUrl}/workingtimes/${userId}${params}`)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("getWorkingTimes", err));
    },
    async getSingleWorkingTime(userId: number, id: number): Promise<any> {
      const { computedUrl } = this;
      console.log("getSingleWorkingTime : ", userId, id);
      return await axios
        .get(`${computedUrl}/workingtimes/${userId}/${id}`)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("getSingleWorkingTime", err));
    },
    async createWorkingTime(
      userId: number,
      start: string,
      end: string
    ): Promise<any> {
      const { computedUrl } = this;
      console.log("createWorkingTime : ", userId, start, end);
      return await axios
        .post(`${computedUrl}/workingtimes/${userId}`, {
          working_time: {
            start: moment(start).format("YYYY-MM-DD HH:mm:ss"),
            end: moment(end).format("YYYY-MM-DD HH:mm:ss"),
          },
        })
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("createWorkingTime", err));
    },
    async updateWorkingTime(id: number, workingTime: any): Promise<any> {
      const { computedUrl } = this;
      console.log("updateWorkingTime : ", id, workingTime);
      return await axios
        .put(`${computedUrl}/workingtimes/${id}`, { working_time: workingTime })
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("updateWorkingTime", err));
    },
    async deleteWorkingTime(id: number): Promise<any> {
      const { computedUrl } = this;
      console.log("deleteWorkingTime : ", id);
      return await axios
        .delete(`${computedUrl}/workingtimes/${id}`)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("deleteWorkingTime", err));
    },

    // ANCHOR - Clock routes
    async getSingleClock(userId: number): Promise<any> {
      const { computedUrl } = this;
      console.log("getSingleClock : ", userId);
      return await axios
        .get(`${computedUrl}/clocks/${userId}`)
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("getSingleClock", err));
    },
    async createClock(
      userId: number,
      time: string,
      status: boolean
    ): Promise<any> {
      const { computedUrl } = this;
      console.log("createClock : ", userId, time, status);
      return await axios
        .post(`${computedUrl}/clocks/${userId}`, {
          clock: { time: moment(time).format("YYYY-MM-DD HH:mm:ss"), status },
        })
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("createClock", err));
    },
    async updateClock(userId: number, clock: any): Promise<any> {
      const { computedUrl } = this;
      console.log("updateClock : ", userId, clock);
      return await axios
        .put(`${computedUrl}/clocks/${userId}`, { clock })
        .then((result: any) => result?.data)
        .catch((err: any) => handleError("updateClock", err));
    },
  },
});
</script>
