import { RouteShorthandOptions } from "fastify";
import S from "fluent-json-schema";

const userResponseInterface = {
  pk_user: {
    type: "string",
  },
  user_name: {
    type: "string",
  },
  user_firstname: {
    type: "string",
  },
  user_lastname: {
    type: "string",
  },
  user_email: {
    type: "string",
  },
  user_phone: {
    type: "string",
  },
  user_dni: {
    type: "string",
  },
  user_age: {
    type: "integer",
  },
  user_createdAt: {
    type: "string",
  },
  user_status: {
    type: "boolean",
  },
};

const schemaUser: RouteShorthandOptions = {
  schema: {
    response: {
      200: {
        data: {
          type: "array",
          properties: userResponseInterface,
        },
        total: {
          type: "integer",
        },
      },
    },
  },
};

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

export { schemaUser, schemaUserRegister, schemaUserId, schemaUserDelete };
