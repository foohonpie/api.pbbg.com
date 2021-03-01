FROM node:lts-alpine as build-stage

# Set working directory
WORKDIR /app

# Copy files for package dependency installation
COPY package.json /app
COPY yarn.lock /app

# install dependencies with frozen lockfile
RUN yarn --frozen-lockfile

# Copy in frontend files for build
COPY . /app

# Build Vue app to create /dist folder
RUN yarn run build \
    && yarn cache clean

# For production
FROM nginx:1.18.0-alpine
RUN mkdir /app
COPY --from=build-stage /app/dist /app
COPY nginx.conf /etc/nginx/nginx.conf
