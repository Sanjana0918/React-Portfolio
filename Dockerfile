FROM node:18 AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Step 2: Serve using NGINX
FROM nginx:latest

# Remove default static files
RUN rm -rf /usr/share/nginx/html/*

# Copy React build output to NGINX directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 3000

#  need for CMD; NGINX starts automatically
CMD ["nginx", "-g", "daemon off;"]
