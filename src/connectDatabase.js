const mysql = require('mysql2/promise');
const fs = require('fs');

async function connectDatabase() {
  const host = process.env.MYSQL_HOST;
  const user = process.env.MYSQL_USER;
  const database = process.env.MYSQL_DATABASE;
  
  // Read password from Docker secret
  let password;
  try {
    password = fs.readFileSync('/run/secrets/db_database_password', 'utf8').trim();
  } catch (error) {
    // Fallback for local development
    password = process.env.MYSQL_PASSWORD;
  }

  const connection = await mysql.createConnection({
    host,
    user,
    password,
    database
  });

  return connection;
}

module.exports = { connectDatabase };
