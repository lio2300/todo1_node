import { FastifyInstance } from "fastify";
import {
  schemaUserRegister,
  schemaUser,
  schemaUserId,
  schemaUserDelete,
} from "../schema/user.schema";
import deleteUser from "./user/delete.user";
import getUser from "./user/get.user";
import getUserId from "./user/getId.user";
import registerUser from "./user/register.user";
import updatedUser from "./user/updated.user";

const Routes = async (fastify: FastifyInstance) => {
  fastify.get("/users", schemaUser, getUser);
  fastify.post("/user", schemaUserRegister, registerUser);
  fastify.get("/user", schemaUserId, getUserId);
  fastify.put("/user", schemaUserRegister, updatedUser);
  fastify.delete("/user", schemaUserDelete, deleteUser);
};

export default Routes;
