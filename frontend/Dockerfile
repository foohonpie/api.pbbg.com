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

# For documentation to developers - EXPOSE command doesn't actually do anything, but tells what should be made open
EXPOSE 3000

# Serve (development server here, don't do in production)
CMD ["yarn", "serve"]
