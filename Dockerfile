FROM alpine:latest

# Set the FiveM and txAdmin version numbers (replace these with actual latest versions)
ENV fivem_version="REPLACE_WITH_FIVEM_VERSION"
ENV txadmin_version="REPLACE_WITH_TXADMIN_VERSION"

EXPOSE 40120
EXPOSE 30120
EXPOSE 30110
EXPOSE 3306  # MySQL port

COPY ./startup.sh /opt/fivem/startup.sh

# Install dependencies
RUN apk add --no-cache libgcc libstdc++ ca-certificates npm tzdata mysql-client mariadb-connector-c

RUN npm install -g fvm-installer

WORKDIR /opt/fivem

ENTRYPOINT ["sh", "/opt/fivem/startup.sh"]