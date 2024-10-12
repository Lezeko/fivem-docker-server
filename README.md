# FiveM Docker Server with MariaDB 🦺

This image provides a FiveM/txAdmin server and database for qbcore/esx. After the first startup, it downloads the defined version from the CFX servers. If there is an update to the server files, simply recreate the container without having to redownload the image again. Everything will be downloaded again (only new) and you can continue.


## Deployment👩‍💻

How to install this Docker Container

1. Have docker and docker compose installed and running.
2. Clone this repo and edit/add versions in `Dockerfile`.
3. Build docker image using this command
```bash
docker build -t fivem-server .
```
4. Edit docker-compose.yml file after you have build image successfully.
```bash
name: fivem-server-stack
services:
  mariadb:
    image: mariadb:latest
    container_name: fivem-mariadb
    environment:
      MYSQL_ROOT_PASSWORD: your_root_password   # Change this to a strong password
      MYSQL_DATABASE: qbcore                    # Name of the database for QBCore
      MYSQL_USER: your_mysql_user               # Create a user for QBCore
      MYSQL_PASSWORD: your_mysql_password       # User's password
    ports:
      - "3306:3306"
    volumes:
      - mariadb_data:/var/lib/mysql  # Persistent data storage
    restart: unless-stopped


    fivem-server:
        container_name: fivem-server
        ports:
            - 40120:40120
            - "30120:30120/udp"
            - "30120:30120/tcp"
            - 30110:30110
        environment:
            - MYSQL_HOST=your_mysql_ip             # Change this to your SQL server IP
            - MYSQL_USER=your_mysql_user           # Change this to your SQL user
            - MYSQL_PASSWORD=your_mysql_password   # Change this to your SQL password
            - MYSQL_DATABASE=qbcore                # Name of the database for QBCore
            - TZ=Europe/Helsinki                   # Change this to your timezone
        volumes:
            - /your/data/location:/opt/fivem/resources # Your folder location
        image: fivem-server
        restart: unless-stopped

volumes:
  mariadb_data:  # Volume for MariaDB data persistence
```
Please replace all things needed.

4. Start docker container
```bash
docker compose up -d
```

5. After all data has been downloaded, mariadb and txAdmin server will start.

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