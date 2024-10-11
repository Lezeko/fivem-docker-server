# FiveM Docker Server 🦺

This image provides a FiveM/txAdmin server and capabilities for database for qbcore. After the first startup, it downloads the defined version from the CFX servers. If there is an update to the server files, simply recreate the container without having to redownload the image again. Everything will be downloaded again (only new) and you can continue.
## Content🧾

* [Deployment👩‍💻](https://github.com/Lezeko/fivem-docker-server?tab=readme-ov-file#deployment)
* [Update/Downgrade⏫](https://github.com/Lezeko/fivem-docker-server?tab=readme-ov-file#up-downgrade)


## Deployment👩‍💻

How to install this Docker Container

1. Have docker and docker compose installed and running.
2. Clone this repo and add your prefered versions in `Dockerfile`.
3. Build docker image using this command
```bash
docker build -t fivem-server .
```
4. Create docker-compose.yml file after you have build image successfully.
```bash
services:
  mariadb:
    image: mariadb:latest
    container_name: mariadb-container
    environment:
      MYSQL_ROOT_PASSWORD: root_password  # Change this to a strong password
      MYSQL_DATABASE: qbcore                # Name of the database for QBCore
      MYSQL_USER: qbcuser                   # Create a user for QBCore
      MYSQL_PASSWORD: user_password          # User's password
    ports:
      - "3306:3306"
    volumes:
      - mariadb_data:/var/lib/mysql  # Persistent data storage

  fivem:
    image: fivem-server  # Replace with your FiveM image name
    container_name: fivem-server
    environment:
      MYSQL_HOST: mariadb           # Hostname of the MariaDB container
      MYSQL_USER: qbcuser           # User for the database
      MYSQL_PASSWORD: user_password   # User's password
      MYSQL_DATABASE: qbcore         # Database name
      TZ: Europe/Berlin              # Set your desired timezone
    ports:
      - "40120:40120"
      - "30120:30120"
      - "30110:30110"
    volumes:
      - ./data:/opt/fivem/resources  # Local directory for FiveM resources

volumes:
  mariadb_data:  # Volume for MariaDB data persistence

```
Please replace all things needed.

4. After all data has been downloaded, the txAdmin server will start.

5. Now the txAdmin server must be set up. This is done via the web interface provided by FiveM.<br>
   [[Here]](https://docs.fivem.net/docs/server-manual/setting-up-a-server-txadmin/#start-the-server) you can read from point 2 on, how to set up txAdmin. (The PIN can be found in the server console)

6. After that the FiveM server will be started and you can play.

<br>

#### Detailed description of the `Dockerfile` versions
1. Insert a link's version version code<br>
    

Here is the FiveM download link:

**Full URL**: https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/6622-d24291cd0e6119311f5b410be6167f6ccdc3e62d/fx.tar.xz

**Base URL**: https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/

**Version Code**: **6622-d24291cd0e6119311f5b410be6167f6ccdc3e62d**


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