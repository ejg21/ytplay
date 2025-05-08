# Use an official Node.js image as the base image
FROM node:20

# Install yt-dlp
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip3 install -U yt-dlp

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
