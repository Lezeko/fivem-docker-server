FROM alpine:latest

# Set the FiveM and txAdmin version numbers (replace these with actual latest versions)
# Latest fivem and txadmin versions (11.10.2024)
ENV fivem_version="10272-72c2081fecb02cee2db0fa40a3977f134fb3d3fc"
ENV txadmin_version="7.2.2"

EXPOSE 40120
EXPOSE 30120
EXPOSE 30110

COPY ./startup.sh /opt/fivem/startup.sh

# Install dependencies
RUN apk add --no-cache libgcc libstdc++ ca-certificates npm tzdata mysql-client mariadb-connector-c

RUN npm install -g fvm-installer

WORKDIR /opt/fivem

ENTRYPOINT ["sh", "/opt/fivem/startup.sh"]