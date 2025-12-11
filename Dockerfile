# Stage 1: Build the React app
FROM node:20.19.0-alpine as build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY my-react-app/package*.json ./

# Install dependencies
RUN npm install

# Copy the remaining application code
COPY my-react-app/ .

# Build the React app
RUN npm run build

# Stage 2: Create a minimal production-ready image
FROM nginx:alpine

# Copy the built app from the 'build' stage
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]