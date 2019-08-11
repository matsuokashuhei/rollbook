FROM node:12

RUN mkdir /app
WORKDIR /app
ADD package.json /app/
RUN npm install
ADD . /app
