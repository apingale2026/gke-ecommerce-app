FROM node:20-slim

WORKDIR /app

# install dependencies first (layer caching)
COPY package.json .
RUN npm install --production

# copy app code
COPY index.js .

CMD ["node", "index.js"]
