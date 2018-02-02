FROM bitnami/node:8.9.3-r0 as builder

# Create app directory
RUN mkdir -p /app/bwallpaper/code
WORKDIR /app/bwallpaper/code

# Install app dependencies
COPY package.json /app/bwallpaper/code
RUN npm install --production --unsafe

# Bundle app source
COPY . /app/bwallpaper/code

FROM bitnami/node:8.9.3-r0-prod
RUN mkdir -p /app/bwallpaper/code
WORKDIR /app/bwallpaper/code
RUN npm install --global pm2
COPY --from=builder /app/bwallpaper/code .
EXPOSE 5000

CMD ["pm2-docker", "--raw", "process.yml"]
