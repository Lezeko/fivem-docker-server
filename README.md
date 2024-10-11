# FiveM Docker Server 🦺

This image provides a FiveM/txAdmin server. After the first startup, it downloads the defined version from the CFX servers. If there is an update to the server files, simply recreate the container without having to redownload the image again. Everything will be downloaded again (only new) and you can continue.
## Content🧾

* [Deployment👩‍💻](https://github.com/Lezeko/fivem-docker-server?tab=readme-ov-file#deployment)
* [Environment Variables🔢](https://github.com/Lezeko/fivem-docker-server?tab=readme-ov-file#environment-variables)
* [Update/Downgrade⏫](https://github.com/Lezeko/fivem-docker-server?tab=readme-ov-file#up-downgrade)


## Deployment👩‍💻

How to install this Docker Container

1. Clone this Github repo.
2. Install and run database (in container?) and create qbcore table.
3. Run that command
```bash
docker run -d \
  --name your_fivem_container_name \
  -p 40120:40120 \
  -p 30120:30120 \
  -p 30110:30110 \
  -e MYSQL_HOST="your_mysql_host" \
  -e MYSQL_USER="your_mysql_user" \
  -e MYSQL_PASSWORD="your_mysql_password" \
  -e MYSQL_DATABASE="qbcore" \
  -e TZ="Europe/Berlin" \  # Set the timezone here
  -v /path/to/your/local/directory:/opt/fivem/resources \  # Mount local directory to resources folder
  your_fivem_image_name
```
Please replace all things written in CAPS.

4. After all data has been downloaded, the txAdmin server will start.

5. Now the txAdmin server must be set up. This is done via the web interface provided by FiveM.<br>
   [[Here]](https://docs.fivem.net/docs/server-manual/setting-up-a-server-txadmin/#start-the-server) you can read from point 2 on, how to set up txAdmin. (The PIN can be found in the server console)

6. After that the FiveM server will be started and you can play.


## Environment Variables🔢

To run this container, you will need to set the following environment variables.

| Variable      | Function      | Default |
|:-------------:|:-------------:|:-------------|
| `download`    |With this variable you can determine which version of the FiveM server will be downloaded.<br>Below you will find a more detailed description of this variable.|recommended|
| `PATH`    |You can ignore this, it will be created automatically by the Alpine base.|/usr/local/sbin:/usr/local/bin:<br>/usr/sbin:/usr/bin:/sbin:/bin|
| `TZ`    |This can be used to set the time zone within the container. Enter a [TZ identifier](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List) for this. When unset its UTC time.|--|


#### Detailed description of the `download` variable
There are 3 ways to use the variable.<br>
1. Set it to 'recommended'<br>
	In that case, the version that can be downloaded at the time of container creation via the "Latest Recommended" button. Seen in the picture below.<br>
 
2. Set it to 'optional'<br>
	In that case, the version that can be downloaded at the time of container creation via the "Latest Optional" button. Seen in the picture below.<br>
 
3. or insert a link of the desired version<br>
   	If you need a specific version of the server, you can also insert the direct link to the desired version file. The link will look like this e.g.<br>
    
```html
https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/6622-d24291cd0e6119311f5b410be6167f6ccdc3e62d/fx.tar.xz
```
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