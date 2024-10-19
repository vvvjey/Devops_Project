require('dotenv').config()
const Sequelize = require("sequelize");
const sequelize = new Sequelize(
  process.env.DB_DATABASE,
  process.env.DB_USERNAME,
  process.env.DB_PASSWORD,
  {
    host : process.env.DB_HOSTNAME,
    port:process.env.DB_PORT,
    dialect:process.env.DB_DIALECT
  }
);
let connectDB = async ()=>{
    try{
        console.log("hehe",sequelize);
        sequelize.authenticate().then(() => {
            console.log('Connection has been established successfully.');
         }).catch((error) => {
            console.error('Unable to connect to the database: ', error);
         });
    } catch(e){
        console.log(e)
    }
}
module.exports= connectDB;