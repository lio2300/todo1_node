import { pgResponse } from "../../interfaces/pg.response";
import { userUpdated } from "./users.query";

const updatedUser = async (request: any, reply: any) => {
  const { body } = request;
  const { code, data, message } = await userUpdated(body, reply);
  reply.code(code);
  reply.send({ data, message });
};

export default updatedUser;
