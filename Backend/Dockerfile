FROM node:18-bullseye

RUN apt-get update && apt-get install -y \
    mariadb-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./


RUN npm install

RUN npm install -g @babel/core @babel/cli

COPY . .

EXPOSE 5000

RUN npm run build-src

CMD ["npm","run","build"]
# CMD ["npm","start"]
