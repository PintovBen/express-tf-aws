FROM node:16
WORKDIR usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000

# Change user to non-root
RUN useradd -u 2525 zeus
USER zeus

# Raise express.js server
CMD ["node", "index.js"]