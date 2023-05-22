FROM debian:buster

# Update & install packages
RUN apt-get update -yq && apt-get install -yq sudo curl unzip

# Create ENV variables
ENV HOME=/home/server
ENV SERVER_HOME=/home/server/tm_server
ENV MAPS=/home/server/tm_server/UserData/Maps

# create server user
RUN mkdir -p /home/server && groupadd server && useradd -g server server && mkdir -p $SERVER_HOME

# install dedicated server files
WORKDIR $HOME
RUN curl -LJO http://files.v04.maniaplanet.com/server/TrackmaniaServer_Latest.zip && \
    unzip TrackmaniaServer_Latest.zip -d tm_server/ && rm TrackmaniaServer_Latest.zip
WORKDIR $SERVER_HOME
COPY server_run.sh .
COPY maps $MAPS
COPY dedicated_cfg.xml /home/server/tm_server/UserData/Config/dedicated_cfg.xml

# switch to server user
RUN chown -R server:server $HOME
USER server
RUN chmod +x ./TrackmaniaServer && chmod +x *.sh

# expose ports
EXPOSE 2351/tcp
EXPOSE 2351/udp
EXPOSE 3451/tcp
EXPOSE 3451/udp
EXPOSE 5006

# docs: https://doc.maniaplanet.com/dedicated-server/references/command-line
CMD "./server_run.sh"