FROM node:14-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# --from=builder -> says from which phase to copy
COPY --from=builder /app/build /usr/share/nginx/html

# default command for nginx is to start the nginx server, so no need to specify it