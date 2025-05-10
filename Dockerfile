# Step 1: Build the React app
FROM node:18-alpine AS build

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy all source files and build the app
COPY . .
RUN npm run build

# Step 2: Serve the app using Nginx
FROM nginx:stable-alpine

# Copy the build output to Nginx's web root
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 and run Nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
