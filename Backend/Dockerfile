FROM node:18-bullseye

# Copy file mariadb-client .deb vào container
COPY mariadb-client_1%3a10.11.8-0ubuntu0.24.04.1_amd64.deb /tmp/mariadb-client.deb

# Cài đặt mariadb-client từ file .deb
RUN apt-get update && apt-get install -y \
    /tmp/mariadb-client.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/mariadb-client.deb
    
WORKDIR /app

COPY package*.json ./


RUN npm install

RUN npm install -g @babel/core @babel/cli

COPY . .

EXPOSE 5000

RUN npm run build-src

CMD ["npm","run","build"]
# CMD ["npm","start"]
