# Sử dụng Node.js để build ứng dụng React/Vue/Angular
FROM node:16 as builder

# Thiết lập thư mục làm việc
WORKDIR /usr/src/app

# Sao chép file package.json và package-lock.json
COPY package.json package-lock.json ./

# Cài đặt dependencies
RUN npm install

# Sao chép mã nguồn và build ứng dụngd
COPY . .
RUN npm run build

# Tạo nginx image để chạy ứng dụng frontend
FROM nginx:1.25

# Sao chép file build từ builder vào Nginx
COPY --from=builder /usr/src/app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Chạy nginx
CMD ["nginx", "-g", "daemon off;"]
