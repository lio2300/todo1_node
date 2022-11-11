import { pgResponse } from "../../interfaces/pg.response";
import { usersRegister } from "./users.query";

const registerUser = async (request: any, reply: any) => {
  const { body } = request;
  const { code, data, message } = await usersRegister(body, reply);
  reply.code(code);
  reply.send({ data, message });
};

export default registerUser;
