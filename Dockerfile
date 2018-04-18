FROM centos:centos7.4.1708


###############################################################################
# System dependencies
###############################################################################
RUN yum --enablerepo=extras install epel-release -y
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm
RUN yum update -y && yum install -y \
    vim \
    httpd \
    php70u \
    php70u-cli \
    php70u-json \
    php70u-mysqlnd
RUN mkdir -p /dataroot
VOLUME ["/dataroot"]

###############################################################################
# Storage Cloud
###############################################################################
COPY php.ini /etc
COPY index.php /
RUN chmod 777 /*.php; \
    chmod 777 /etc/php.ini
RUN mkdir -p /data/storagecloud ;\
    rm -rf /var/www/html ;\
    ln -s /data/storagecloud /var/www/html
EXPOSE 80

###############################################################################
# Vagrant Cloud
###############################################################################
RUN wget -q https://github.com/ryandoyle/vagrancy/releases/download/0.0.4/vagrancy-0.0.4-linux-x86_64.tar.gz -O /vagrancy.tar.gz ;\
    tar xf /vagrancy.tar.gz --strip 1 ;\
    ln -s /
CMD /vagrancy
EXPOSE 8099



###############################################################################
# Start script
###############################################################################
COPY start.sh /
RUN chmod 777 /start.sh

###############################################################################
# Make sure that everything is written to disk
###############################################################################
RUN sync

###############################################################################
# Start container services
###############################################################################
ENTRYPOINT /start.sh && /bin/bash