# Use an official Node.js 16 image as the base image
FROM node:16

# Install necessary packages including Python, pip, and python3-venv
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv

# Create a virtual environment and install yt-dlp
RUN python3 -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install yt-dlp

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# Expose the port your app will run on
EXPOSE 3000

# Start the Node.js application
CMD ["node", "server.js"]
