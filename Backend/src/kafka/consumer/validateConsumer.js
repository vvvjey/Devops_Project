const kafka = require('../config/kafkaConfig');
const consumer = kafka.consumer({ groupId: 'inventory-update-group' });
const { sendInventoryUpdateMessage } = require('../producer/inventoryProducer');
const db = require('../../models/index');


async function startValidateConsumer() {
  await consumer.connect();
  await consumer.subscribe({ topic: 'Order-Validated', fromBeginning: true });

  await consumer.run({
    eachMessage: async ({ message,topic, partition }) => {
      console.log("validate consumerer message",message.value.toString(),partition,"offset ", message.offset);
      const { orderId, isValid } = JSON.parse(message.value.toString());
      if (isValid) {
        console.log("Order is valid ")
      } else {
        let order = await db.Order.findOne({
          where:{
            orderId:orderId
          }
        });
        order.state = "Failed"
        await order.save();
        console.log("Đơn hàng không hợp lệ, không cập nhật tồn kho.");
      }
    },
  });
}

module.exports = { startValidateConsumer };
