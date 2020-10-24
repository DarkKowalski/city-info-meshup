FROM node:alpine
# use mirrors for users in China
RUN npm --registry https://registry.npm.taobao.org install -g http-server
WORKDIR /app
COPY ./frontend/package*.json ./
RUN npm --registry https://registry.npm.taobao.org install
COPY ./frontend .
RUN npm run build
EXPOSE 8080
CMD [ "http-server", "dist" ]
