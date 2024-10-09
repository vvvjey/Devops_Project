-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 09, 2024 lúc 06:33 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `web_cv`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `carts`
--

CREATE TABLE `carts` (
  `cartId` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `carts`
--

INSERT INTO `carts` (`cartId`, `userId`, `createdAt`, `updatedAt`) VALUES
(26, 13, '2024-02-27 02:17:54', '2024-02-27 02:17:54'),
(27, 15, '2024-03-08 15:14:18', '2024-03-08 15:14:18');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart_details`
--

CREATE TABLE `cart_details` (
  `cartDetailId` int(11) NOT NULL,
  `cartId` int(11) DEFAULT NULL,
  `productDetailId` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `cart_details`
--

INSERT INTO `cart_details` (`cartDetailId`, `cartId`, `productDetailId`, `quantity`, `createdAt`, `updatedAt`) VALUES
(23, 25, 23, 2, '2024-02-27 02:16:58', '2024-02-27 02:17:13'),
(46, 26, 14, 1, '2024-07-23 07:20:01', '2024-07-23 07:20:01'),
(47, 26, 18, 4, '2024-07-23 07:20:15', '2024-09-22 09:13:50');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `categoryId` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chats`
--

CREATE TABLE `chats` (
  `chatId` int(11) NOT NULL,
  `senderId` int(11) DEFAULT NULL,
  `receiverId` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `chats`
--

INSERT INTO `chats` (`chatId`, `senderId`, `receiverId`, `createdAt`, `updatedAt`) VALUES
(1, 13, 14, '2024-06-06 09:02:29', '2024-06-06 09:02:29'),
(2, 13, 15, '2024-06-06 14:00:27', '2024-06-06 14:00:27'),
(6, 15, 14, '2024-06-09 05:13:00', '2024-06-09 05:13:00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `collections`
--

CREATE TABLE `collections` (
  `collectionId` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `intro` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `comments`
--

CREATE TABLE `comments` (
  `commentId` int(11) NOT NULL,
  `orderId` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `starRate` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `comments`
--

INSERT INTO `comments` (`commentId`, `orderId`, `description`, `starRate`, `createdAt`, `updatedAt`) VALUES
(1, 1, 'good', 5, '2024-03-16 04:03:13', '2024-03-16 04:03:13'),
(2, 2, 'ok', 5, '2024-03-16 05:21:45', '2024-03-16 05:21:45'),
(3, 3, 'wow', 5, '2024-03-16 05:25:40', '2024-03-16 05:25:40'),
(4, 1, 'From bottom of my heart , i cannot deny that this is the power,the significant,the wonderful , the most beautiful i got in my fashion life, OMG  so fucking crazy , i love it so much!!!!! <3 <3', 5, '2024-03-16 08:41:19', '2024-03-16 08:41:19'),
(5, 2, '', 2, '2024-03-31 09:44:53', '2024-03-31 09:44:53');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `messages`
--

CREATE TABLE `messages` (
  `messageId` int(11) NOT NULL,
  `senderId` int(11) DEFAULT NULL,
  `chatId` int(11) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `messages`
--

INSERT INTO `messages` (`messageId`, `senderId`, `chatId`, `text`, `createdAt`, `updatedAt`) VALUES
(1, 13, 1, 'hello chat', '2024-06-06 14:29:57', '2024-06-06 14:29:57'),
(2, 13, 1, 'how are u bae', '2024-06-06 14:30:08', '2024-06-06 14:30:08'),
(3, 14, 1, 'im fine', '2024-06-06 14:32:40', '2024-06-06 14:32:40'),
(4, 13, 1, 'ok', '2024-06-06 16:46:26', '2024-06-06 16:46:26'),
(5, 13, 1, 'hello ', '2024-06-07 08:03:55', '2024-06-07 08:03:55'),
(6, 13, 1, 'jey day', '2024-06-07 08:04:00', '2024-06-07 08:04:00'),
(7, 14, 1, 'vay a', '2024-06-07 08:04:05', '2024-06-07 08:04:05'),
(8, 13, 1, 'real?', '2024-06-07 08:04:43', '2024-06-07 08:04:43'),
(9, 13, 1, 'for real', '2024-06-07 08:07:53', '2024-06-07 08:07:53'),
(10, 13, 1, 'EE', '2024-06-07 08:13:01', '2024-06-07 08:13:01'),
(11, 13, 1, 'ok', '2024-06-07 08:14:42', '2024-06-07 08:14:42'),
(12, 14, 1, 'ok', '2024-06-09 03:37:00', '2024-06-09 03:37:00'),
(13, 13, 1, 'ok', '2024-06-09 03:37:11', '2024-06-09 03:37:11'),
(14, 13, 1, 'e', '2024-06-09 04:04:24', '2024-06-09 04:04:24'),
(15, 13, 1, 'sao z', '2024-06-09 04:05:17', '2024-06-09 04:05:17'),
(16, 13, 1, '', '2024-06-09 04:05:59', '2024-06-09 04:05:59'),
(17, 13, 1, 'e', '2024-06-09 04:08:49', '2024-06-09 04:08:49'),
(18, 13, 1, 'sao', '2024-06-09 04:09:06', '2024-06-09 04:09:06'),
(19, 14, 1, 'ok', '2024-06-09 04:09:09', '2024-06-09 04:09:09'),
(20, 13, 1, 'ok', '2024-06-09 04:09:19', '2024-06-09 04:09:19'),
(21, 15, 5, 'hello', '2024-06-09 05:09:02', '2024-06-09 05:09:02'),
(22, 15, 6, 'hello', '2024-06-09 05:13:20', '2024-06-09 05:13:20'),
(23, 14, 6, 'hi', '2024-06-09 05:13:30', '2024-06-09 05:13:30');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `orderId` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `addressShipping` varchar(255) DEFAULT NULL,
  `isRate` tinyint(1) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`orderId`, `userId`, `total`, `state`, `addressShipping`, `isRate`, `createdAt`, `updatedAt`) VALUES
(1, 13, 103, 'Paymented', '65 hung vuong', 1, '2024-03-16 04:02:26', '2024-03-17 02:20:32'),
(2, 13, 52, 'Paymented', '65 hung vuong', 1, '2024-03-16 05:21:26', '2024-03-31 09:44:53'),
(3, 15, 13, 'Paymented', '123', 0, '2024-03-16 05:25:25', '2024-03-16 05:25:33');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_details`
--

CREATE TABLE `order_details` (
  `orderDetailId` int(11) NOT NULL,
  `orderId` int(11) DEFAULT NULL,
  `productDetailId` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `order_details`
--

INSERT INTO `order_details` (`orderDetailId`, `orderId`, `productDetailId`, `quantity`, `createdAt`, `updatedAt`) VALUES
(1, 1, 21, 1, '2024-03-16 04:02:26', '2024-03-16 04:02:26'),
(2, 1, 14, 1, '2024-03-16 04:02:26', '2024-03-16 04:02:26'),
(3, 1, 23, 2, '2024-03-16 04:02:26', '2024-03-16 04:02:26'),
(4, 2, 16, 1, '2024-03-16 05:21:26', '2024-03-16 05:21:26'),
(5, 2, 18, 1, '2024-03-16 05:21:26', '2024-03-16 05:21:26'),
(6, 3, 21, 1, '2024-03-16 05:25:25', '2024-03-16 05:25:25');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `productId` int(11) NOT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `collectionId` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `salePercent` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`productId`, `categoryId`, `collectionId`, `name`, `price`, `description`, `salePercent`, `createdAt`, `updatedAt`) VALUES
(1, 2, NULL, 'COTTON CREW SOCKS 3 PACK', 32, NULL, NULL, '2024-07-13 09:34:18', '2024-07-13 09:34:18'),
(2, 2, NULL, 'CURREN CREW SOCKS', 11, NULL, NULL, '2024-07-13 09:35:38', '2024-07-13 09:35:38'),
(3, 2, NULL, 'PURE BOXER BRIEF WHOLESTER', 30, NULL, NULL, '2024-02-16 07:36:32', '2024-02-16 07:36:32'),
(4, 2, NULL, 'RAMP CAMO BOXER BRIEF', 25, NULL, NULL, '2024-02-16 07:40:58', '2024-02-16 07:40:58'),
(5, 2, NULL, 'BANISTER BOXER BRIEF', 11, NULL, NULL, '2024-02-16 07:43:26', '2024-02-16 07:43:26'),
(6, 2, NULL, 'STAPLE BOXER BRIEF WHOLESTER', 30, NULL, NULL, '2024-02-16 07:45:26', '2024-02-16 07:45:26'),
(7, 2, NULL, 'BUTTER BLEND™ CREW SOCKS', 12, NULL, NULL, '2024-07-13 09:36:07', '2024-07-13 09:36:07'),
(10, 2, NULL, 'hung', 25, NULL, NULL, '2024-02-25 08:43:46', '2024-02-25 08:43:46'),
(114, 2, NULL, 'real product', 22, NULL, NULL, '2024-07-14 09:09:07', '2024-07-14 09:09:07');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_details`
--

CREATE TABLE `product_details` (
  `productDetailId` int(11) NOT NULL,
  `productId` int(11) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `size` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL,
  `stock` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product_details`
--

INSERT INTO `product_details` (`productDetailId`, `productId`, `img`, `size`, `color`, `stock`, `createdAt`, `updatedAt`) VALUES
(13, 3, 'https://stance.eu.com/cdn/shop/products/21_FEEL360_UW_PURE_BACK.jpg?v=1633527681', 'S', 'black', 20, '2024-02-16 07:36:32', '2024-02-16 07:36:32'),
(14, 3, 'https://stance.eu.com/cdn/shop/products/21_FEEL360_UW_PURE_BACK.jpg?v=1633527681', 'M', 'black', 20, '2024-02-16 07:36:57', '2024-02-16 07:36:57'),
(15, 3, 'https://stance.eu.com/cdn/shop/products/21_FEEL360_UW_PURE_BACK.jpg?v=1633527681', 'L', 'black', 20, '2024-02-16 07:37:00', '2024-02-16 07:37:00'),
(16, 4, 'https://stance.eu.com/cdn/shop/products/M801A21RAM_AMG_ALT_01.jpg?v=1613490399', 'S', 'camo', 20, '2024-02-16 07:40:58', '2024-02-16 07:40:58'),
(17, 4, 'https://stance.eu.com/cdn/shop/products/M801A21RAM_AMG_ALT_01.jpg?v=1613490399', 'M', 'camo', 20, '2024-02-16 07:41:09', '2024-02-16 07:41:09'),
(18, 4, 'https://stance.eu.com/cdn/shop/products/M801A21RAM_AMG_ALT_01.jpg?v=1613490399', 'M', 'gray', 20, '2024-02-16 07:42:06', '2024-02-16 07:42:06'),
(19, 4, 'https://stance.eu.com/cdn/shop/products/M801A21RAM_AMG_ALT_01.jpg?v=1613490399', 'L', 'gray', 20, '2024-02-16 07:42:12', '2024-02-16 07:42:12'),
(21, 5, 'https://stance.eu.com/cdn/shop/products/M802D23BAN_BLK_ALT_01.jpg?v=1696327932', 'S', 'black', 20, '2024-02-16 07:43:26', '2024-02-16 07:43:26'),
(22, 6, 'https://stance.eu.com/cdn/shop/products/M901A20ST6_HGR_ALT_01_9f354ee8-74c0-4348-91a1-acf680f64571.jpg?v=1687238023', 'S', 'black', 20, '2024-02-16 07:45:26', '2024-02-16 07:45:26'),
(23, 6, 'https://stance.eu.com/cdn/shop/products/M901A20ST6_HGR_ALT_01_9f354ee8-74c0-4348-91a1-acf680f64571.jpg?v=1687238023', 'M', 'black', 20, '2024-02-16 07:45:34', '2024-02-16 07:45:34'),
(24, 6, 'https://stance.eu.com/cdn/shop/products/M901A20ST6_HGR_ALT_01_9f354ee8-74c0-4348-91a1-acf680f64571.jpg?v=1687238023', 'S', 'white', 20, '2024-02-16 07:45:54', '2024-02-16 07:45:54'),
(30, 10, 'https://bizweb.dktcdn.net/100/442/306/products/screenshot-8-1701857877357.png?v=1701859450703', 'M', 'red', 96, '2024-02-25 08:43:46', '2024-02-25 08:43:46'),
(31, 1, 'https://www.stance.com/dw/image/v2/BGWC_PRD/on/demandware.static/-/Sites-GlobalProductCatalog/default/dwad9327e8/images/products/A556C24WEE_ICB.jpg?sw=800&sh=800', 'M', 'Red', 22, '2024-07-13 09:34:19', '2024-07-13 09:34:19'),
(32, 2, 'https://www.stance.com/dw/image/v2/BGWC_PRD/on/demandware.static/-/Sites-GlobalProductCatalog/default/dw8b07fb48/images/products/A556A20CHS_BLU.jpg?sw=800&sh=800', 'M', 'Blue', 22, '2024-07-13 09:35:38', '2024-07-13 09:35:38'),
(33, 7, 'https://www.stance.com/dw/image/v2/BGWC_PRD/on/demandware.static/-/Sites-GlobalProductCatalog/default/dw578b435d/images/products/A556A23SHE_BLK.jpg?sw=800&sh=800', 'M', 'Blue', 22, '2024-07-13 09:36:07', '2024-07-13 09:36:07'),
(34, 114, 'https://res.cloudinary.com/dkpoexuvj/image/upload/v1720948251/z8dyb02gn77koiar1vp5.png', 'M', 'Red', 22, '2024-07-14 09:10:52', '2024-07-14 09:10:52');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sequelizemeta`
--

CREATE TABLE `sequelizemeta` (
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sequelizemeta`
--

INSERT INTO `sequelizemeta` (`name`) VALUES
('migration-create-cart_detail.js'),
('migration-create-cart.js'),
('migration-create-category.js'),
('migration-create-chat.js'),
('migration-create-collection.js'),
('migration-create-comment.js'),
('migration-create-message.js'),
('migration-create-order_detail.js'),
('migration-create-order.js'),
('migration-create-product_detail.js'),
('migration-create-product.js'),
('migration-create-user.js');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `refreshToken` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `address`, `password`, `refreshToken`, `role`, `createdAt`, `updatedAt`) VALUES
(13, 'abc', 'hoangtu', '65 hung vuong', '$2b$10$36juoX10nZp40xJnVNFV3./4b8HcEnwzsZ1WLxR9m715Lu/h6hcoa', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImhvYW5ndHUiLCJlbWFpbCI6ImFiYyIsImlhdCI6MTcwOTAwMDI3NCwiZXhwIjoxNzA5MDA2Mjc0fQ.oV2rhzd-HmhcSjLi0CKfQDIr9YMzVspVbd0TCf4UpWA', 'R01', '2024-02-27 02:17:54', '2024-02-27 02:17:54'),
(14, NULL, 'hoangtu1', NULL, '$2b$10$lXknKl996mtwHXMq.o7TmOvIoKS3iCPi6mGYfvnMbt1JKgIgqivvy', NULL, 'R02', '2024-02-27 08:50:46', '2024-02-27 08:50:46'),
(15, 'abc', 'abc', '123', '$2b$10$DxooHTYrYy5Lfc1zfj8G0ORch3s0KC53Q1CWgf2gB5rjekSLS0q8.', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFiYyIsImVtYWlsIjoiYWJjIiwiaWF0IjoxNzA5OTEwODU4LCJleHAiOjE3MDk5NDY4NTh9.HtOH9Ov0HY7QQtHpX2g0YHX_gpOWN50e2tutUKq5VqM', 'R01', '2024-03-08 15:14:18', '2024-03-08 15:14:18');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`cartId`);

--
-- Chỉ mục cho bảng `cart_details`
--
ALTER TABLE `cart_details`
  ADD PRIMARY KEY (`cartDetailId`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`categoryId`);

--
-- Chỉ mục cho bảng `chats`
--
ALTER TABLE `chats`
  ADD PRIMARY KEY (`chatId`);

--
-- Chỉ mục cho bảng `collections`
--
ALTER TABLE `collections`
  ADD PRIMARY KEY (`collectionId`);

--
-- Chỉ mục cho bảng `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`commentId`);

--
-- Chỉ mục cho bảng `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`messageId`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderId`);

--
-- Chỉ mục cho bảng `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`orderDetailId`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`productId`);

--
-- Chỉ mục cho bảng `product_details`
--
ALTER TABLE `product_details`
  ADD PRIMARY KEY (`productDetailId`),
  ADD UNIQUE KEY `uniqueConstraint` (`productId`,`color`,`size`);

--
-- Chỉ mục cho bảng `sequelizemeta`
--
ALTER TABLE `sequelizemeta`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `carts`
--
ALTER TABLE `carts`
  MODIFY `cartId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT cho bảng `cart_details`
--
ALTER TABLE `cart_details`
  MODIFY `cartDetailId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `categoryId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `chats`
--
ALTER TABLE `chats`
  MODIFY `chatId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `collections`
--
ALTER TABLE `collections`
  MODIFY `collectionId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `comments`
--
ALTER TABLE `comments`
  MODIFY `commentId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `messages`
--
ALTER TABLE `messages`
  MODIFY `messageId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `orderId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `order_details`
--
ALTER TABLE `order_details`
  MODIFY `orderDetailId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `productId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT cho bảng `product_details`
--
ALTER TABLE `product_details`
  MODIFY `productDetailId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
