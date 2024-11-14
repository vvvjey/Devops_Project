const kafka = require('../config/kafkaConfig');
const producer = kafka.producer();

async function sendOrderValidatedMessage(validationData) {
  const {orderId,isValid} = validationData;
    // Log giá trị orderId trước khi gửi
    console.log("Thông điệp gửi đi:", JSON.stringify(orderId,isValid)); // Log thông điệp

  await producer.connect();
  await producer.send({
    topic: 'Order-Validated',
    messages: [{ value: JSON.stringify({orderId,isValid}) }],
  });
  await producer.disconnect();
  console.log("Đã gửi kết quả validate tới topic 'Order-Validated'",validationData);
}

module.exports = { sendOrderValidatedMessage };
