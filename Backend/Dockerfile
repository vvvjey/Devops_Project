FROM node:18-bullseye

WORKDIR /app

COPY package*.json ./


RUN npm install

RUN npm install -g @babel/core @babel/cli

COPY . .

EXPOSE 5000

RUN npm run build-src

CMD ["npm","run","build"]
# CMD ["npm","start"]
