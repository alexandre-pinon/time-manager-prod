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
      .post(`${url}/users`, { user: { username, email }})
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
}

const api = new API();
export default api;
