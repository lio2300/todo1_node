import { users } from "./users.query";

const getUser = async (request: any, reply: any) => {
  const { query } = request;
  const { code, data, total } = await users(query, reply);

  reply.code(code);
  reply.send({ data, total });
};

export default getUser;
