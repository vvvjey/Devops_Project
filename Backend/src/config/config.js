require('dotenv').config();

module.exports= {
  development: {
    username: 'root',
    password: '123',
    database: 'web_cv',
    host: '146.190.193.223',
    port:'3306',
    dialect: 'mysql'
  },
  test: {
    username: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    host: process.env.DB_HOSTNAME,
    port:process.env.DB_PORT,
    dialect: process.env.DB_DIALECT
  },
  production: {
    username: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    host: process.env.DB_HOSTNAME,
    port:process.env.DB_PORT,
    dialect: process.env.DB_DIALECT
  }
};
