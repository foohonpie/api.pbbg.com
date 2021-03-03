FROM node:lts-alpine

# Set working directory
WORKDIR /app

# Copy files for package dependency installation
COPY package.json .
COPY yarn.lock .

RUN yarn --frozen-lockfile

# Copy in frontend files for build
COPY . .

# Build Vue app to create /dist folder
RUN yarn run build

# Serve (development server here, don't do in production)
CMD ["yarn", "serve"]
