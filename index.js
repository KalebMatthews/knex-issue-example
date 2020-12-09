const { connection } = require('./app-settings');
const { serializeError } = require("serialize-error");

const knex = require('knex')({
    client: 'mssql',
    connection: {
        database: connection.database,
        server: connection.host,
        password: connection.password,
        port: connection.port,
        user: connection.user,
        options: {
            enableArithAbort: true,
            encrypt: false
        },
        pool: { min: 0, max: 150 }
    }
});

const insertPrimary = {
    data: "Testing Data"
};

const insertSecondary = {
    name: "Test Linking"
}


async function insertRows() {
    try {
        const primaryId = await knex("primary_table").insert([insertPrimary], ["id"]);
        insertSecondary["looping_id"] = primaryId[0];

        console.log("returning value: ", await knex("secondary_table").insert([insertSecondary], ["id"]));
    } catch (err) {
        console.log(serializeError(err));
    }
}

insertRows();