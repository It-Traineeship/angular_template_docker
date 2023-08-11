FROM node:16 as builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install -g @angular/cli
RUN npm install
COPY . .
RUN ng build

# Stage 2: Serve the Angular application with Nginx
FROM nginx:alpine
COPY --from=builder /usr/src/app/dist/angular_template /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
