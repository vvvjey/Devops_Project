// src/kafka/index.js

const { sendMessage } = require('./producer/producer');
const { startConsumer } = require('./consumer/consumer');
const { startOrderConsumer } = require('./consumer/orderConsumer');
const { startValidateConsumer } = require('./consumer/validateConsumer');
const { startInventoryConsumer } = require('./consumer/inventoryConsumer');

const topic = 'my-topic';

// Khởi chạy Consumer và gửi một tin nhắn để thử nghiệm
// (async () => {
//   // Bắt đầu Consumer để lắng nghe các tin nhắn từ Kafka
//   startConsumer(topic);
  
//   // Gửi tin nhắn test từ Producer
//   setTimeout(() => {
//     sendMessage(topic, 'Hello Kafka!');

    
//   }, 5000); // Đợi 5 giây để chắc chắn Consumer đã kết nối
// })();

(async () => {
  await startOrderConsumer();      // Consumer cho Order-Received
  await startValidateConsumer();   // Consumer cho Order-Validated
  // await startInventoryConsumer();  // Consumer cho Inventory-Update
})();