import { userDeleted } from "./users.query";

const deleteUser = async (request: any, reply: any) => {
  const { body } = request;
  const { code, data, message } = await userDeleted(body, reply);

  reply.code(code);
  reply.send({ data, message });
};

export default deleteUser;
