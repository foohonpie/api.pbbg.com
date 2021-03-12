PBBG.com - Multi-Container App
===============
This repo demonstrates a multi-container docker app that decouples concerns between containers for an ideal development
experience in a team of open source contributors with various tech and language specialties as well as ease of deployment
since all services and containers can more easily be moved as one/at once and restarted with a single docker command.

## Prerequisites
* Docker engine
* Docker Compose
* Internet Connection
* Ensure no other web server is running on your host machine's port 80

## Docker Containers
| Container     | Service                         | Internal Port |External Port|
|:--------------|:--------------------------------|:--------------|:------------|
| `/frontend`   | User Interface with Vue.js      | 3000          |             |
| `/backend`    | API with Laravel 8              | 9000          |             |
| `/database`   | Database with Mysql             | 3306          |             |
| `/proxy`      | Reverse proxy with Nginx        | 80            |80           |

#### How to start this project locally
1. Ensure you have prerequisites (see above)
2. Fork, clone, go to project directory.
3. Create your `.env` in project root and copy content of `.env.example`
4. Run shell script located at `./local-start.sh`
> You may need to grant 'execute script' permissions to any of the .sh scripts in this project before you can use them.

After everything is started, you can find the application running on `http://localhost`, and the backend (API) is
accessible by hitting an example endpoint at `http://localhost/api/tests`.

#### Accessing database locally
1. Get your containers up and running (see above steps).
2. Run `docker inspect database`
3. At the end of the output, you'll see a `Networks` section, showing `pbbgcom_pbbg` as the network.
4. Use the `IPAddress` value, along with your `.env` credentials, to connect to the database from your host machine.

## Using VSCode?
Because the containers are isolated, you will need to open a new window if you wish to edit the frontend and backend simultaneously.

1. Install 'Remote Containers' and 'Remote Development' extensions. This allows for editing a project inside a Docker container.
2. Open VSCode and select "Remote Containers: Open Folder from Container" from the Command Palette.
3. Select either the `frontend` or `backend` folder. This will boot up the entire project from the `docker-compose.local.yml` file and then attach you to the appropriate folder.
4. If you want to open the other folder, repeat Step 3. This will attach you to the already-running containers.
