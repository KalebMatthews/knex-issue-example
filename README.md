# knex-issue-example

## Setup
  1. `npm install`
  2. Create app-settings.js
  3. Add the following code to the file:
  ```
  module.exports = {
      connection: {
          host: "<server ip address>",
          user: "<mssql server user>",
          password: "<mssql server user password>",
          port: <open port to mssql server>,
          database: "KnexIssueExample <Change if the database name in the initial SQL script is changed>"
      }
  }
  ```
  4. Run the init.sql script on your mssql server to create the test database.
  5. `npm run start` to run the problemmatic scenario
