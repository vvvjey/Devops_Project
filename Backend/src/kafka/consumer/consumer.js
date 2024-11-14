// src/kafka/consumer/consumer.js

const kafka = require('../config/kafkaConfig');
const consumer = kafka.consumer({ groupId: 'test-group' });

async function startConsumer(topic) {
  await consumer.connect();
  await consumer.subscribe({ topic, fromBeginning: true });

  await consumer.run({
    eachMessage: async ({ topic, partition, message }) => {
      console.log({
        topic,
        partition,
        offset: message.offset,
        value: message.value.toString(),
      });
    },
  });
}

module.exports = { startConsumer };
