# FiveM Docker Server (BROKEN CONFIG) 🦺

This image provides a FiveM/txAdmin server and capabilities for database for qbcore. After the first startup, it downloads the defined version from the CFX servers. If there is an update to the server files, simply recreate the container without having to redownload the image again. Everything will be downloaded again (only new) and you can continue.
## Content🧾

* [Deployment👩‍💻](https://github.com/Lezeko/fivem-docker-server?tab=readme-ov-file#deployment)
* [Update/Downgrade⏫](https://github.com/Lezeko/fivem-docker-server?tab=readme-ov-file#up-downgrade)


## Deployment👩‍💻

How to install this Docker Container

1. Have docker and docker compose installed and running.
2. Clone this repo and edit/add versions in `Dockerfile`.
3. Build docker image using this command
```bash
docker build -t fivem-server .
```
4. Create docker-compose.yml file after you have build image successfully.
```bash
docker run -d \
  --name fivem-server \
  -p 40120:40120 \
  -p 30120:30120 \
  -p 30110:30110 \
  -e MYSQL_HOST="your_sql_ip" \
  -e MYSQL_USER="your_user" \
  -e MYSQL_PASSWORD="your_password" \
  -e MYSQL_DATABASE="qbcore" \
  -e TZ="Europe/Helsinki" \
  -v ./data:/opt/fivem/resources \
  fivem-server



services:
  mariadb:
    image: mariadb:latest
    container_name: mariadb
    environment:
      MYSQL_ROOT_PASSWORD: root  # Change this to a strong password
      MYSQL_DATABASE: qbcore                # Name of the database for QBCore
      MYSQL_USER: qbcuser                   # Create a user for QBCore
      MYSQL_PASSWORD: qbcore          # User's password
    ports:
      - "3306:3306"
    volumes:
      - mariadb_data:/var/lib/mysql  # Persistent data storage
volumes:
  mariadb_data:  # Volume for MariaDB data persistence
```
Please replace all things needed.

4. Start docker container
```bash
docker compose up -d
```

5. After all data has been downloaded, the txAdmin server will start.

6. Now the txAdmin server must be set up. This is done via the web interface provided by FiveM.<br>
   [[Here]](https://docs.fivem.net/docs/server-manual/setting-up-a-server-txadmin/#start-the-server) you can read from point 2 on, how to set up txAdmin. (The PIN can be found in the server console)

7. After that the FiveM server will be started and you can play.

<br>

#### Detailed description of the `Dockerfile` versions
1. Insert a link's version version code<br>
    

Here is the FiveM download link:

**Full URL**: https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/10272-72c2081fecb02cee2db0fa40a3977f134fb3d3fc/fx.tar.xz

**Base URL**: https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/

**Version Code**: **10272-72c2081fecb02cee2db0fa40a3977f134fb3d3fc**


All versions can be found [->HERE](https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/)<br>
 
![image](https://github.com/Auhrus/fivem-docker-server/assets/57270834/8752e275-54ca-4ba7-a141-473bc0be4d70 "CFX artifacts")

<br><br>
How the server get started:

```bash
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
	
exec $SCRIPTPATH/alpine/opt/cfx-server/ld-musl-x86_64.so.1 \
--library-path "$SCRIPTPATH/alpine/usr/lib/v8/:$SCRIPTPATH/alpine/lib/:$SCRIPTPATH/alpine/usr/lib/" -- \
$SCRIPTPATH/alpine/opt/cfx-server/FXServer +set citizen_dir $SCRIPTPATH/alpine/opt/cfx-server/citizen/ $*
```


## Up-/Downgrade⏫

How do i change the version of my FiveM Server?

1. First stop and remove the existing Container.
```shell
docker stop CONAINER_NAME && docker rm CONAINER_NAME
```
2. Then create him again like in the [Deployment👩‍💻](https://github.com/Auhrus/fivem-docker-server?tab=readme-ov-file#deployment) with the same Volumes.

**Please note** that downgrading may cause compatibility problems e.g. with the txAdmin database.