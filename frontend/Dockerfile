FROM node:lts-alpine AS builder

# Set working directory
WORKDIR /app

# Copy files for package dependency installation
COPY package.json .
COPY yarn.lock .

RUN yarn --frozen-lockfile

# Copy in frontend files for build
COPY . .

# Lint source code and fail if issues
RUN yarn lint || exit 1

# Build Vue app to create /dist folder
RUN yarn build

# Final stage build
FROM node:lts-alpine
WORKDIR /app

RUN apk update \
    && apk add jq curl

RUN jq -n '{"name": "ui","description": "","version": "0.1.0","dependencies": {"express": "^4.17.1","serve-static": "^1.14.1"},"devDependencies": {}}' > package.json
RUN yarn

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/server.js .

# For documentation to developers - EXPOSE command doesn't actually do anything, but tells what should be made open
EXPOSE 3000

CMD ["node", "server.js"]
