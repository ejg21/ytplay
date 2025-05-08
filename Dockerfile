# Use a Node.js 18 base image
FROM node:18-slim

# Set working directory
WORKDIR /app

# Install dependencies and set up yt-dlp in a virtual environment
RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    curl \
    ffmpeg \
    && python3 -m venv /opt/venv \
    && /opt/venv/bin/pip install --no-cache-dir -U pip yt-dlp \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add virtualenv to PATH so yt-dlp can be used globally
ENV PATH="/opt/venv/bin:$PATH"

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy app files
COPY . .

# Expose the port
EXPOSE 3000

# Start the app
CMD ["node", "server.js"]
