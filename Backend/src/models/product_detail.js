'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class product_detail extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      product_detail.belongsTo(models.product,{foreignKey:"productId",targetKey:"productId"})
      product_detail.belongsTo(models.Cart_detail, { foreignKey: "productDetailId", targetKey: "productDetailId" });
      product_detail.belongsTo(models.Order_detail, { foreignKey: "productDetailId" }); // Changed foreign key
    }
  }
  product_detail.init({
    productId: {
      type:DataTypes.INTEGER,
    },
    productDetailId: {
      primaryKey:true,
      type:DataTypes.INTEGER,
      autoIncrement:true
    },
    img: DataTypes.STRING,
    size: {
      type:DataTypes.STRING,
    },
    color: {
      type:DataTypes.STRING,
    },
    stock:DataTypes.INTEGER,
  }, {
    sequelize,
    modelName: 'product_detail',
  });
  return product_detail;
};