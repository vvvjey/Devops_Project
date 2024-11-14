const kafka = require('../config/kafkaConfig');
const consumer = kafka.consumer({ groupId: 'final-inventory-update-group' });
const db = require('../../models');

async function startInventoryConsumer() {
  await consumer.connect();
  await consumer.subscribe({ topic: 'Inventory-Update', fromBeginning: true });

  await consumer.run({
    eachMessage: async ({ message }) => {
      const { orderId } = JSON.parse(message.value.toString());
      console.log("Nhận yêu cầu cập nhật tồn kho từ topic 'Inventory-Update'", { orderId });

      // Cập nhật tồn kho cho các sản phẩm trong đơn hàng
      const orderDetails = await db.Order_detail.findAll({ where: { orderId } });
      await Promise.all(orderDetails.map(async (item) => {
        const productDetail = await db.Product_detail.findByPk(item.productDetailId);
        if (productDetail) {
          await productDetail.update({ stock: productDetail.stock - item.quantity });
        }
      }));

      console.log(`Đã cập nhật tồn kho cho đơn hàng ID: ${orderId}`);
    },
  });
}

module.exports = { startInventoryConsumer };
