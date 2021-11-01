/* eslint-disable @typescript-eslint/no-explicit-any */
import axios from "axios";
import _ from "lodash";
import moment from "moment";

import { handleError } from "@/utils/helpers";
import config from "../config.json";

class API {
  url = "http://localhost";
  port = "4000";

  constructor(url = "", port = "") {
    this.port = port || this.port;
    this.url = `${url || this.url}:${this.port}/api`;
  }

  createUser = async (username: string, email: string): Promise<any> => {
    const { url } = this;
    console.log("createUser : ", username, email);
    return await axios
      .post(`${url}/users`, { user: { username, email } })
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("createUser", err));
  };
  updateUser = async (id: number, user: any): Promise<any> => {
    const { url } = this;
    console.log("updateUser : ", id, user);
    return await axios
      .put(`${url}/users/${id}`, { user })
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("updateUser", err));
  };
  deleteUser = async (id: number): Promise<any> => {
    const { url } = this;
    console.log("deleteUser : ", id);
    return await axios
      .delete(`${url}/users/${id}`)
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("deleteUser", err));
  };
  getUser = async (id: number): Promise<any> => {
    const { url } = this;
    console.log("getUser : ", id);
    return await axios
      .get(`${url}/users/${id}`)
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("getUser", err));
  };
  getUsers = async (): Promise<any> => {
    const { url } = this;
    console.log("getUsers");
    return await axios
      .get(`${url}/users`)
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("getUsers", err));
  };

  createWorkingTime = async (
    id: number, // user ID, not working time ID
    start: string,
    end: string
  ): Promise<any> => {
    const { url } = this;
    console.log("createWorkingTime : ", id, start, end);
    return await axios
      .post(`${url}/workingtimes/${id}`, {
        working_time: {
          start: moment(start).format("YYYY-MM-DD HH:mm:ss"),
          end: moment(end).format("YYYY-MM-DD HH:mm:ss"),
        },
      })
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("createWorkingTime", err));
  };
  updateWorkingTime = async (id: number, workingTime: any): Promise<any> => {
    const { url } = this;
    console.log("updateWorkingTime : ", id, workingTime);
    return await axios
      .put(`${url}/workingtimes/${id}`, { working_time: workingTime })
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("updateWorkingTime", err));
  };
  deleteWorkingTime = async (id: number): Promise<any> => {
    const { url } = this;
    console.log("deleteWorkingTime : ", id);
    return await axios
      .delete(`${url}/workingtimes/${id}`)
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("deleteWorkingTime", err));
  };
  getWorkingTime = async (id: number): Promise<any> => {
    const { url } = this;
    console.log("getWorkingTime : ", id);
    return await axios
      .get(`${url}/workingtimes/${id}`)
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("getWorkingTime", err));
  };
  getWorkingTimes = async (
    id: number, // user ID, not working time ID
    start: any = undefined,
    end: any = undefined
  ): Promise<any> => {
    const { url } = this;
    console.log("getWorkingTimes : ", id, start, end);
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
            (val: any, key: any) => `${key}=${moment(val).format("YYYY-MM-DD")}`
          ).join("&")
        : "";
    return await axios
      .get(`${url}/workingtimes/users/${id}${params}`)
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("getWorkingTimes", err));
  };
  getAllWorkingTimes = async (): Promise<any> => {
    const { url } = this;
    console.log("getAllWorkingTimes");
    return await axios
      .get(`${url}/workingtimes`)
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("getAllWorkingTimes", err));
  };

  createClock = async (
    id: number, // user ID, not clock ID
    time: string,
    status: boolean
  ): Promise<any> => {
    const { url } = this;
    console.log("createClock : ", id, time, status);
    return await axios
      .post(`${url}/clocks/${id}`, {
        clock: { time: moment(time).format("YYYY-MM-DD HH:mm:ss"), status },
      })
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("createClock", err));
  };
  updateClock = async (id: number, clock: any): Promise<any> => {
    const { url } = this;
    console.log("updateClock : ", id, clock);
    return await axios
      .put(`${url}/clocks/${id}`, { clock })
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("updateClock", err));
  };
  deleteClock = async (id: number): Promise<any> => {
    const { url } = this;
    console.log("deleteClock : ", id);
    return await axios
      .delete(`${url}/clocks/${id}`)
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("deleteClock", err));
  };
  getClock = async (id: number): Promise<any> => {
    const { url } = this;
    console.log("getClock : ", id);
    return await axios
      .get(`${url}/clocks/${id}`)
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("getClock", err));
  };
  getClocks = async (id: number): Promise<any> => {
    // user ID, not clock ID
    const { url } = this;
    console.log("getClocks : ", id);
    return await axios
      .get(`${url}/clocks/users/${id}`)
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("getClocks", err));
  };
  getAllClocks = async (): Promise<any> => {
    const { url } = this;
    console.log("getAllClocks");
    return await axios
      .get(`${url}/clocks`)
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("getAllClocks", err));
  };
}

const api = process.env.NODE_ENV === 'production' ? new API(`http://${config.API_HOST}`, config.API_PORT) : new API();
export default api;
