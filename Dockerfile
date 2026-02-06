FROM node:20-alpine

# Create app directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy source files
COPY src ./src

# Expose port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
