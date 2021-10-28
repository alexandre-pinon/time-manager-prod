/* eslint-disable @typescript-eslint/no-explicit-any */
import axios from "axios";
import _ from "lodash";
import moment from "moment";

const handleError = (source: string, err: any): void => {
  console.error("API | " + source + " > ", err);
};

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
      .post(`${url}/workingtimes/${id}`, { working_time: { start, end } })
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("createWorkingTime", err));
  };
  updateWorkingTime = async (id: number, workingTime: any): Promise<any> => {
    const { url } = this;
    console.log("updateWorkingTime : ", id, workingTime);
    return await axios
      .put(`${url}/workingtimes/${id}`, { workingTime })
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
      .get(`${url}/workingtimes/${id}${params}`)
      .then((result: any) => result?.data)
      .catch((err: any) => handleError("getWorkingTimes", err));
  };
}

const api = new API();
export default api;
