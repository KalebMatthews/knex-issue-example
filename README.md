# knex-issue-example

## Setup
  1. Run `npm install`
  2. Create app-settings.js in the projects root directory.
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
  5. Setup user security rights to the newly created database
  6. `npm run start` to run the problemmatic scenario
