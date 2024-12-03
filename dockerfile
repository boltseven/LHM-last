# Use the official Node.js image to build the React app
FROM node:18 AS build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the app's source code
COPY . .

# Build the React app
RUN npm run build

# Use the official Nginx image for serving the static files
FROM nginx:stable-alpine

# Copy the nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the built files to the Nginx html folder
COPY --from=build /app/dist /usr/share/nginx/html

# Expose the port Nginx will run on
EXPOSE 83

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]