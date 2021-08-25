FROM ubuntu:latest

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget && \
    apt-get install xz-utils 

WORKDIR /home

#Get the lastest Stable headless version
RUN wget https://www.factorio.com/get-download/stable/headless/linux64

#Rename the file
RUN mv linux64 factorio.tar.xz

#Extract tar.xz
RUN tar -xf factorio.tar.xz

#Tidyup
RUN rm factorio.tar.xz 

#Create the needed folder for mounting
RUN mkdir factorio/mods && \
    mkdir factorio/saves && \
    mkdir factorio/settings

#Create the recommended factorio user
RUN useradd factorio && \
    chown -R factorio:factorio /home/factorio

CMD factorio/bin/x64/factorio --server-settings factorio/settings/server-settings.json --start-server-load-latest 