const kafka = require('../config/kafkaConfig');
const producer = kafka.producer();

async function sendInventoryUpdateMessage(orderId) {
  await producer.connect();
  await producer.send({
    topic: 'Inventory-Update',
    messages: [{ value: JSON.stringify({ orderId }) }],
  });
  await producer.disconnect();
  console.log("Đã gửi cập nhật tồn kho tới topic 'Inventory-Update'");
}

module.exports = { sendInventoryUpdateMessage };
