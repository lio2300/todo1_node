# Todo1 NodeJS

### Pre-requisites

Install the Angular CLI globally:

- Install [Node.js](https://nodejs.org/en/) version 8.0.0
- Install [PostgreSQL](https://www.postgresql.org/) version 15
- Import file SQL `database.sql`
- Install [Docker](https://www.docker.com/) ultima version

### Getting started

- Clone the repository

```
git clone  <git lab template url> <project_name>
```

- Install dependencies

```
cd <project_name>
npm install
```

- Build and run the project

```
npm start
```

Navigate to `http://localhost:8001`

- API Document endpoints

  Get all users Method:GET : http://localhost:5000/api/users

  Get user by id Method:GET : http://localhost:5000/api/user

  Register user Method:POST : http://localhost:5000/api/user

  Update user Method:PUT : http://localhost:5000/api/user

  Delete user Method:DELETE : http://localhost:5000/api/user

## Docker

Docker is an open source project that automates the use of applications within software containers, it requires an additional capacity of abstraction and automation of application virtualization in multiple operating systems.

Complied Docker

```
docker build -t todo1_node .
```

Run Docker

```
docker run -d -it -p 5000:5000 todo1_node
```

In your Browse

```
localhost:5000
```

# TypeScript + Node

The main purpose of this repository is to show a project setup and workflow for writing microservice. The Rest APIs will be using the Swagger (OpenAPI) Specification.

## Getting TypeScript

Add Typescript to project `npm`.

```
npm install -D typescript
```
