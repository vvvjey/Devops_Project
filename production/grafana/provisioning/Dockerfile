# Sử dụng base image của Grafana
FROM grafana/grafana:latest

# Sao chép file cấu hình vào container
COPY grafana /etc/grafana/provisioning

# Expose port 3000 (Grafana mặc định chạy trên cổng này)
EXPOSE 3000

# Chạy Grafana
CMD ["/run.sh"]
