const { Pool } = require("pg");
var config = {
  user: "postgres",
  database: "todo1",
  password: "123456789",
  host: "localhost",
  port: 5432,
};
const pool = new Pool(config);

export { pool };
