const kafka = require('../config/kafkaConfig');
const producer = kafka.producer();

async function sendOrderReceivedMessage(orderData,orderId) {
  await producer.connect();
  await producer.send({
    topic: 'Order-Received',
    messages: [{ value: JSON.stringify({orderData,orderId}) }],
  });
  await producer.disconnect();
  console.log("Đã gửi thông tin đơn hàng tới topic 'Order-Received' với orderId là",orderId,"với data đơn hàng : ",orderData);
}

module.exports = { sendOrderReceivedMessage };
