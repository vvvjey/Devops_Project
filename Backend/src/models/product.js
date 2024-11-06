'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class product extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      product.hasMany(models.product_detail,{foreignKey:"productId"})
    }
  }
  product.init({
    productId: {
      type:DataTypes.INTEGER,
      primaryKey:true,
      autoIncrement:true
    },
    name: DataTypes.STRING,
    categoryId: DataTypes.STRING,
    collectionId: DataTypes.STRING,
    price:DataTypes.INTEGER,
    description:DataTypes.STRING,
    salePercent:DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'product',
  });
  return product;
};