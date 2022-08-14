const mysqlConnection = require('mysql');

module.exports = mysqlConnection.createConnection ({
    host:'localhost',
    user:'root',
    password:'',
    port:3306,
    database:'sistem'
});