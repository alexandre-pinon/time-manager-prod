/* eslint-disable @typescript-eslint/no-explicit-any */
import axios from "axios";

class API {
  url = "http://localhost";
  port = "4000";

  constructor(url = "", port = "") {
    this.port = port || this.port;
    this.url = `${url || this.url}:${this.port}/api`;
  }

  handleError = (source: string, err: any): any => {
    console.error("API | " + source + " > ", err);
  };

  createUser = async (username: string, email: string): Promise<any> => {
    const { url } = this;
    console.log("createUser : ", username, email);
    return await axios
      .post(`${url}/users`, { user: { username, email } })
      .then((result: any) => result?.data)
      .catch((err: any) => this.handleError("createUser", err));
  };
  updateUser = async (id: number, user: any): Promise<any> => {
    const { url } = this;
    console.log("updateUser : ", id, user);
    return await axios
      .put(`${url}/users/${id}`, { user })
      .then((result: any) => result?.data)
      .catch((err: any) => this.handleError("updateUser", err));
  };
  deleteUser = async (id: number): Promise<any> => {
    const { url } = this;
    console.log("deleteUser : ", id);
    return await axios
      .delete(`${url}/users/${id}`)
      .then((result: any) => result?.data)
      .catch((err: any) => this.handleError("deleteUser", err));
  };
  getUser = async (id: number): Promise<any> => {
    const { url } = this;
    console.log("getUser : ", id);
    return await axios
      .get(`${url}/users/${id}`)
      .then((result: any) => result?.data)
      .catch((err: any) => this.handleError("getUser", err));
  };

  createWorkingTime = async (
    id: number, // user ID, not working time ID
    start: string,
    end: string
  ): Promise<any> => {
    const { url } = this;
    console.log("createWorkingTime : ", start, end);
    return await axios
      .post(`${url}/workingtimes/${id}`, { working_time: { start, end } })
      .then((result: any) => result?.data)
      .catch((err: any) => this.handleError("createWorkingTime", err));
  };
  updateWorkingTime = async (id: number, workingTime: any): Promise<any> => {
    const { url } = this;
    console.log("updateWorkingTime : ", id, workingTime);
    return await axios
      .put(`${url}/workingtimes/${id}`, { workingTime })
      .then((result: any) => result?.data)
      .catch((err: any) => this.handleError("updateWorkingTime", err));
  };
  deleteWorkingTime = async (id: number): Promise<any> => {
    const { url } = this;
    console.log("deleteWorkingTime : ", id);
    return await axios
      .delete(`${url}/workingtimes/${id}`)
      .then((result: any) => result?.data)
      .catch((err: any) => this.handleError("deleteWorkingTime", err));
  };
}

const api = new API();
export default api;
