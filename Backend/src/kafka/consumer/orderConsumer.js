const kafka = require('../config/kafkaConfig');
const db = require('../../models/index');

const consumer = kafka.consumer({ groupId: 'order-validation-group' });
const { sendOrderValidatedMessage } = require('../producer/validateProducer');

async function startOrderConsumer() {
  await consumer.connect();
  await consumer.subscribe({ topic: 'Order-Received', fromBeginning: true });

  await consumer.run({
    eachMessage: async ({ message,topic, partition }) => {
      const { orderData, orderId } = JSON.parse(message.value.toString());
      console.log("Nhận thông tin đơn hàng từ topic 'Order-Received'", {
        topic,
        partition,
        offset: message.offset,
        value: message.value.toString(),
      } );

      // Thực hiện validate đơn hàng
      const isValid = await validateOrder(orderData,orderId);  
      // Gửi kết quả validate tới 'Order-Validated'
      await sendOrderValidatedMessage({ orderId, isValid });
    },
  });
}

async function validateOrder(orderData, orderId) {
  console.log('ham ', orderData, "hehe", orderId);
  
  // Thực hiện lặp qua từng item trong orderData
  for (const item of orderData) {
    console.log(item);
    console.log("quantity", item.quantity);
    
    let productDetail = await db.Product_detail.findOne({
      where: {
        productDetailId: item.productDetailId
      }
    });
    
    console.log("productDetail : ", productDetail);
    
    // Kiểm tra hàng tồn kho
    if (productDetail.stock < item.quantity) {
      return false;  
    } else {
      productDetail.stock -= item.quantity; 
      await productDetail.save(); 
    }
  }
  
  return true;  
}

module.exports = { startOrderConsumer };
