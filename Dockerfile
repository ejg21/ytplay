# Use a Node.js 16+ base image
FROM node:18-slim

# Set working directory
WORKDIR /app

# Install dependencies and yt-dlp
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    curl \
    ffmpeg \
    && pip3 install --no-cache-dir -U yt-dlp \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy app files
COPY . .

# Expose the port
EXPOSE 3000

# Start the app
CMD ["node", "server.js"]
