# Sử dụng Jenkins LTS làm hình ảnh cơ sở
FROM jenkins/jenkins:lts

# Cài đặt thêm các gói cần thiết (tùy chọn)
USER root
RUN apt-get update && apt-get install -y \
    curl \
    vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Trở về người dùng Jenkins
USER jenkins

# Mở cổng 8080 (cổng mặc định của Jenkins)
EXPOSE 8080
