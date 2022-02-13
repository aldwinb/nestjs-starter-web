FROM node:17-alpine3.14

RUN npm i -g @nestjs/cli

WORKDIR /home/app

COPY ["package.json", "/home/app"]

RUN cd /home/app \
  && npm install \
  cd -
