import { pool } from "../../config/db";
import getFunctionsPg, { functionsPg } from "../../config/functions.pg";
import { pgResponse } from "../../interfaces/pg.response";
import { userBody, userParams } from "../../interfaces/users.interfaces";

const users = (params: userParams, reply: any): Promise<pgResponse> => {
  return new Promise((resolve, reject) => {
    pool.query(
      getFunctionsPg(functionsPg.user),
      ["user_table", params],
      (err: any, res: any) => {
        if (err) {
          reject(err);
          return;
        }
        const {
          rows: [{ response }],
        } = res;
        const { code } = response;
        if (code === 503) reject(response);
        resolve(response);
      }
    );
  });
};
const usersRegister = (body: userBody, reply: any): Promise<pgResponse> => {
  return new Promise((resolve, reject) => {
    pool.query(
      getFunctionsPg(functionsPg.user),
      ["user_register", body],
      (err: any, res: any) => {
        if (err) {
          reject(err);
          return;
        }
        const {
          rows: [{ response }],
        } = res;
        const { code } = response;
        if (code === 503) reject(response);
        resolve(response);
      }
    );
  });
};
const userId = (body: userBody, reply: any): Promise<pgResponse> => {
  return new Promise((resolve, reject) => {
    pool.query(
      getFunctionsPg(functionsPg.user),
      ["user_id", body],
      (err: any, res: any) => {
        if (err) {
          reject(err);
          return;
        }
        const {
          rows: [{ response }],
        } = res;
        const { code } = response;
        if (code === 503) reject(response);
        resolve(response);
      }
    );
  });
};
const userUpdated = (body: userBody, reply: any): Promise<pgResponse> => {
  return new Promise((resolve, reject) => {
    pool.query(
      getFunctionsPg(functionsPg.user),
      ["user_update", body],
      (err: any, res: any) => {
        if (err) {
          reject(err);
          return;
        }
        const {
          rows: [{ response }],
        } = res;
        const { code } = response;
        if (code === 503) reject(response);
        resolve(response);
      }
    );
  });
};
const userDeleted = (body: userBody, reply: any): Promise<pgResponse> => {
  return new Promise((resolve, reject) => {
    pool.query(
      getFunctionsPg(functionsPg.user),
      ["user_delete", body],
      (err: any, res: any) => {
        if (err) {
          reject(err);
          return;
        }
        const {
          rows: [{ response }],
        } = res;
        const { code } = response;
        if (code === 503) reject(response);
        resolve(response);
      }
    );
  });
};

export { users, usersRegister, userId, userUpdated, userDeleted };
