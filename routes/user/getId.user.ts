import { userId, users } from "./users.query";

const getUserId = async (request: any, reply: any) => {
  const { query } = request;
  const { code, data } = await userId(query, reply);

  reply.code(code);
  reply.send({ data });
};

export default getUserId;
