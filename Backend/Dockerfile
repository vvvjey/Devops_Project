FROM node:18-bullseye

WORKDIR /app

COPY package*.json ./


RUN npm install

RUN npm install -g @babel/core @babel/cli

RUN npm install -g newman

COPY . .

EXPOSE 5000

RUN npm run build-src

CMD ["npm","start"]
