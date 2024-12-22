FROM node:18-alpine

RUN sed -i 's|http://dl-cdn.alpinelinux.org|http://mirror.cs.uchicago.edu|g' /etc/apk/repositories \
    && apk update \
    && apk add --no-cache mariadb-client


WORKDIR /hoangtu1289/backend

COPY package*.json ./


RUN npm install

RUN npm install -g @babel/core @babel/cli

COPY . .

EXPOSE 5000

RUN npm run build-src

CMD ["npm","run","build"]
# CMD ["npm","start"]
