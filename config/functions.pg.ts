const functionsPg: any = {
  user: "todo1_user",
};

const getFunctionsPg = (fcPg: string): string => {
  return `SELECT * FROM ${fcPg}($1, $2)`;
};

export default getFunctionsPg;
export { functionsPg };
