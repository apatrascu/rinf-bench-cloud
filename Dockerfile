FROM centos:centos7.4.1708


###############################################################################
# System dependencies
###############################################################################
RUN yum --enablerepo=extras install epel-release -y
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm
RUN yum update -y && yum install -y \
    vim \
    wget \
    httpd \
    php70u \
    php70u-cli \
    php70u-json \
    java-1.8.0-openjdk \
    net-tools \
    php70u-mysqlnd
RUN mkdir -p /dataroot
RUN chmod 777 /dataroot
VOLUME ["/dataroot"]


###############################################################################
# Storage Cloud
###############################################################################
COPY php.ini /etc
COPY index.php /
RUN chmod 777 /*.php ;\
    chmod 777 /etc/php.ini
EXPOSE 80


###############################################################################
# Docker registry
###############################################################################
COPY ./registry/registry /bin/registry
COPY ./registry/config-example.yml /etc/docker/registry/config.yml
COPY ./registry/ld-musl-x86_64.so.1 /
COPY docker-entrypoint.sh /entrypoint.sh

EXPOSE 5000

###############################################################################
# Vagrant Cloud
###############################################################################
RUN wget -q https://github.com/ryandoyle/vagrancy/releases/download/0.0.4/vagrancy-0.0.4-linux-x86_64.tar.gz -O /vagrancy.tar.gz ;\
    tar xf /vagrancy.tar.gz --strip 1

EXPOSE 8099

###############################################################################
# Docker Repo
###############################################################################
RUN mkdir /gitbucket_data
COPY ./gitbucket.sh /opt/gitbucket.sh
COPY ./gitbucket_data/ /gitbucket_data/
ENV GITBUCKET_VER 4.23.0
RUN wget -q https://github.com/gitbucket/gitbucket/releases/download/$GITBUCKET_VER/gitbucket.war -O /opt/gitbucket.war

EXPOSE 8080

################################################################################
## Start script
################################################################################
COPY start.sh /
RUN chmod 777 /start.sh

###############################################################################
# Make sure that everything is written to disk
###############################################################################
RUN sync

###############################################################################
# Start container services
###############################################################################
#ENTRYPOINT /entrypoint.sh /etc/docker/registry/config.yml & /start.sh & /vagrancy & /bin/bash
ENTRYPOINT /start.sh & /bin/bash