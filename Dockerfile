FROM ubuntu:24.04

# UCSC Genome Browser Website Dockerfile
ADD http://raw.githubusercontent.com/ucscGenomeBrowser/kent/master/src/product/installer/browserSetup.sh /root/browserSetup.sh

# Update ubuntu and install dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -yq wget rsync

# run the ucsc setup script and change the mode to mariadb
ENV PATH="$PATH:/root/"
RUN chmod a+x /root/browserSetup.sh && browserSetup.sh -b install && apt-get clean
RUN sed -i '/^.mysqld.$/a sql_mode=' /etc/mysql/mariadb.conf.d/50-server.cnf

# add the ucsc tools (blat etc.)
# RUN browserSetup.sh addTools

# take it offline
# RUN browserSetup.sh -o

# expose port 80 and setup the run script
EXPOSE 80
CMD service mariadb start && apachectl -D FOREGROUND
