// src/kafka/producer/producer.js

const kafka = require('../config/kafkaConfig');
const producer = kafka.producer();

async function sendMessage(topic, message) {
  await producer.connect();
  await producer.send({
    topic,
    messages: [
      { value: message },
    ],
  });
  await producer.disconnect();
  console.log(`Đã gửi tin nhắn tới topic "${topic}": ${message}`);
}

module.exports = { sendMessage };
