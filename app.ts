import Fastify, { FastifyInstance } from "fastify";
import Routes from "./routes/main";

const fastify: FastifyInstance = Fastify({});

fastify.register(Routes, { prefix: "/api" });

const start = async () => {
  try {
    fastify.listen({ port: 5000 });

    const address = fastify.server.address();
    const port = typeof address === "string" ? address : address?.port;
  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};
start();
