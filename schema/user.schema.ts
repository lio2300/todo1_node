import { RouteShorthandOptions } from "fastify";
import S from "fluent-json-schema";

const userTable = S.object()
  .prop("offset", S.integer())
  .required()
  .prop("limit", S.integer())
  .required()
  .prop("search", S.string())
  .required();

const userBody = S.object()
  .prop("pk_user", S.string())
  .prop("user_name", S.string())
  .required()
  .prop("user_firstname", S.string())
  .required()
  .prop("user_lastname", S.string())
  .required()
  .prop("user_email", S.string())
  .required()
  .prop("user_phone", S.string())
  .required()
  .prop("user_dni", S.string())
  .required()
  .prop("user_age", S.integer())
  .required()
  .prop("user_status", S.boolean())
  .required();

const userId = S.object().prop("pk_user", S.number()).required();
const userDelete = S.object().prop("pk_user", S.number()).required();

const schemaUserRegister = {
  schema: {
    body: userBody,
  },
};
const schemaUserId = {
  schema: {
    querystring: userId,
  },
};
const schemaUserDelete = {
  schema: {
    body: userDelete,
  },
};
const schemaUser = {
  schema: {
    querystring: userTable,
  },
};

export { schemaUser, schemaUserRegister, schemaUserId, schemaUserDelete };
