PBBG.com - Multi-Container App
===============
This repo demonstrates a multi-container docker app that decouples concerns between containers for an ideal development 
experience in a team of open source contributors with various tech and language specialties as well as ease of deployment 
since all services and containers can more easily be moved as one/at once and restarted with a single docker command.

## Prerequisites
* Docker engine
* Docker Compose
* Internet Connection
> Really, this is all. No PHP, no Node, no Composer/Artisan, no sql, no other vm tech, no laravel sail

## Shared configuration
The `.env` file's variables within the root of the project are executed in the context of **all containers** as each builds, which 
provides global environment configuration across them. Additional files like `.env.production` can be made for specific production 
  values and referenced during the docker-compose commands.

## Container Orchestration
The application is composed of distinct and independent "containers" which each provide a service.

| Container     | Service                         | Internal Port |External Port|
|:--------------|:--------------------------------|:--------------|:------------|
| `/frontend`   | User Interface with Vue.js      | 80            |             |
| `/backend`    | API with Laravel 8              | 9000          |             |
| `/database`   | Database with Mysql             | 3306, 33060   |             |
| `/proxy`      | Reverse proxy with Nginx        | 8000          |80           |


### Architecture Diagram
<img src="https://i.ibb.co/PmdHnyX/Overview.png" alt="PBBG.com: Multi-Container Application Diagram" width="10000"/>

#### Using Docker-Compose
`./docker-compose.yml` - This file orchestrates each docker container - how the images are built, how containers start and stop,
what ports are open to the world, what volumes are synchronized to the host machine. Additionally we can create different levels
of orchestration by defining other yml files, like `docker-compose.development.yml` which might synchronize more things, or log more, or
serve things in a debug mode or using a different kind of "mode". This allows us flexibility to work the way we want in development,
and then to "lock things down" or optimize/obscure/secure things for production.

Here's a highlight of what this project's architecture is equipped to do:
* Place Backend, Frontend, Database, and Proxy each in their own container
* Put all containers in the same Docker network which allows secure internal container communication while only exposing port 80 via the Proxy
* Controls the start and "depends_on" order of services - Backend requires Database, Frontend requires Backend, etc...
* Controls the Proxy nginx configuration which can be updated/deployed with the Multi-Container Application as a whole to production
* Mounts volumes for the Backend and Frontend so that files can be edited locally (on the developer's host machine) and they do not "disappear" when the containers are shut down or destroyed
* Entire set of containers together or just individual ones can be started/stopped.
* Entire different configuration files like `docker-compose.development.yml` or `docker-compose.test.yml` could potentially be made with `Dockerfile.dev` or `Dockerfile.test` files alongside `.env.development` or `.env.test` files 
to allow for complete flexibility in build and deployment.
  
#### NGINX for Reverse Proxy
The internals of how containers talk to each other are inside the `./proxy/pbbg.conf` file.  It's quite short:
```bash
server {
    listen 80;
    server_name localhost;
    error_log  /var/log/nginx/error.log;
    access_log /var/log/nginx/access.log;
    location / {
        root   /app;
        index  index.html;
        try_files $uri $uri/ /index.html;
    }
    location /api {
        proxy_pass http://backend:8000;
    }
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
      root   /usr/share/nginx/html;
    }
}
```
And correspondingly, this is the proxy as defined by `./docker-compose.yml`:
```bash
  proxy:
    image: nginx:1.18.0-alpine
    container_name: proxy
    restart: on-failure
    ports:
      - 8000:80
    environment:
      - CHOKIDAR_USEPOLLING=true
    volumes:
      - ./proxy:/etc/nginx/conf.d
      - ./frontend/dist:/app
    depends_on:
      - database
      - backend
      - frontend
    networks:
      - pbbg
```
Things to note:
* Because of the mounted volume the frontend can build *outside* of the Proxy (also outside the Backend) container and when it 
produces stuff in `/dist` that directory is immediately sync'd to the proxy container's internal `/app` directory. And the `pbbg.conf` 
nginx location of `root /app;` means that it will serve that.
* Nginx also uses `proxy_pass` whenever a path has `/api` on it. `proxy_pass` sends to the *internal* network "backend" service on the specified port.
* The other mounted volume is the `pbbg.conf` file itself - allowing on the fly changes/refreshes.

## We don't need Laravel Sail
Using it will make overall Deployment and Development for PBBG.com more complicated than it needs to be, place artificial constraints on us, and will cost more time than it saves. As stated on their official website:
> Laravel Sail is a light-weight command-line interface for interacting with Laravel's default Docker ***development*** (emphasis mine) environment.
 
However, there are more complicated requirements that PBBG.com already needs than what Laravel Sail provides out of the box.

A short, non-comprehensive list of needs that Sail doesn't try to handle:
* Package up the docker containers for production (developing containers in hot reload mode while working, but separate production images that strip out cruft)
* Deployment plan and reliable CI pipeline plan
* SSL and Certs - and how to develop with that configuration in place/toggled on or off

A smaller list of "nice-but-expected-to-haves" that Sail doesn't try to handle:
* Other important web features that are basic security/optimization: CSP Policy management, http2 support, gzip/brotli compression
* Decoupling of frontend technology from the API server (i.e. control of the frontend compile, packing, build tooling)

Docker and Docker-Compose actually provide strategies to help accomplish the above items, and I can agree that it's a lot to do. 
I don't mean to dog on Laravel Sail. It's fair that Sail doesn't set out to boil the ocean in what it offers. However, the cost 
of using Sail as it is *and then also* falling back to normal docker stuff to simply accomplish the things we know we'll need would 
make the build tooling more convoluted than it needs to be.

But if we step back for a moment and look at what Sail is really doing, I think you'll find that after you understand how it works that we 
can (and many of us do) manage containers just fine without it.

> [This article](https://tech.osteel.me/posts/you-dont-need-laravel-sail) goes into a lot more detail about how Sail works under the hood, and I arrived at the author's same conclusion at the 
> end.

Long story short, any command that uses the `sail` binary, like:
```bash
./vendor/bin/sail laravelContainer composer --version
./vendor/bin/sail laravelContainer composer install
./vendor/bin/sail laravelContainer composer require jenssegers/mongodb

./vendor/bin/sail laravelContainer php artisan serve
./vendor/bin/sail laravelContainer php artisan migrate
./vendor/bin/sail laravelContainer php artisan key:generate

./vendor/bin/sail laravelContainer build
./vendor/bin/sail laravelContainer up -d
```
is actually a pretty simple wrapper around `docker-compose` using an image with *all those things* installed within, and they can be invoked directly:
```bash
docker-compose exec laravelContainer composer --version
docker-compose exec laravelContainer composer install
docker-compose exec laravelContainer composer require jenssegers/mongodb

docker-compose exec laravelContainer php artisan serve
docker-compose exec laravelContainer php artisan migrate
docker-compose exec laravelContainer php artisan key:generate

docker-compose exec laravelContainer build
docker-compose exec laravelContainer up -d
```

And that's exactly what the project in this repo allows for.  Taking a look at the `/backend/Dockerfile` you'll find that the php, composer, 
artisan requirements are all pulled into that image and available for use in exactly that way. This project is actually ready to use, as is, if we want 
to go this direction.

#### How to start this project locally
1. Ensure you have prerequisites (see above)
2. Fork, clone, go to project directory.
3. Copy `.env.example` into `.env`.  
4. `docker-compose build frontend backend`
5. `docker-compose up` or instead run in background with `docker-compose up -d`

After everything is started, you can find the application running on `http://localhost:8000`, and the backend (API) is 
accessible by hitting an example endpoint at `http://localhost:8000/api/tests`.
