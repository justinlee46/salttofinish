FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install software-properties-common python-software-properties wget -y
RUN wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
RUN touch /etc/apt/sources.list.d/saltstack.list && echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" >> /etc/apt/sources.list.d/saltstack.list
RUN apt-get update
RUN apt-get install salt-api salt-master salt-minion -y
RUN apt-get install vim -y
RUN apt-get install python-pip -y
RUN apt-get install curl -y
RUN pip install boto boto3
# Default version of CherryPy is very old and breaks TLS
RUN pip install --upgrade cherrypy

EXPOSE 1338
VOLUME /srv/salt

# Sleeps exist here since the master and minion must be up sequentially to connect properly
CMD cp /srv/salt/salt_config/docker_master /etc/salt/master &&\
    cp /srv/salt/salt_config/docker_minion /etc/salt/minion &&\
    cp -R /srv/salt/salt_config/master.d /etc/salt/. &&\
    /etc/init.d/salt-master start &&\
    /etc/init.d/salt-minion start &&\
    sleep 30 &&\
    salt-key -A -y &&\
    sleep 30 &&\
    salt '*' tls.create_ca localhost &&\
    cp /etc/pki/localhost/localhost_ca_cert.key /etc/ssl/private/key.pem &&\
    cp /etc/pki/localhost/localhost_ca_cert.crt /etc/ssl/private/cert.pem &&\
    service salt-api start &&\
    service docker start &&\
    tail -f /var/log/salt/master
