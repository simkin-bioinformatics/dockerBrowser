# install docker engine
https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository

remove sudo requirement
https://docs.docker.com/engine/install/linux-postinstall/

install ucsc docker image
	mkdir browserDocker && cd browserDocker
	wget https://raw.githubusercontent.com/ucscGenomeBrowser/kent/master/src/product/installer/docker/Dockerfile
	docker build . -t gbimage

run the docker image with a local mount point
	docker run -d --name genomeBrowser -p 8080:80 gbimage
	docker run -d --name genomeBrowser -p 1234:80 --mount type=bind,source=/home/charlie/Documents/genomeBrowser_files,target=/usr/local/apache/htdocs/folders gbimage
	DocumentRoot is /usr/local/apache/htdocs

bash into the docker container
	docker exec -it genomeBrowser /bin/bash


install micro
	curl https://getmic.ro | bash

allow for calling custom tracks locally
	/usr/local/apache/cgi-bin/hg.conf

password protect
	https://www.digitalocean.com/community/tutorials/how-to-set-up-password-authentication-with-apache-on-ubuntu-14-04
	install apache utilities
		sudo apt-get update
		sudo apt-get install apache2 apache2-utils
	create password file
		sudo htpasswd -c /etc/apache2/.htpasswd sammy
		leave off the -c to add another user to same file
	edit the conf file
		micro /etc/apache2/sites-enabled/001-browser.conf
	add a directory block
		<Directory "/">
	        AuthType Basic
	        AuthName "Restricted Content"
	        AuthUserFile /etc/apache2/.htpasswd
	        Require valid-user
    	</Directory>
    restart apache
    	service apache2 restart

 Take it offline
 	/root/browserSetup.sh -o

 http://74.111.60.108:1234/folders/

 http://74.111.60.108:1234/cgi-bin/hgTracks?db=hub_113_dfam_reconstituted&lastVirtModeType=default&lastVirtModeExtraState=&virtModeType=default&virtMode=0&nonVirtPosition=&position=Copia_I%3A1%2D5145&hgsid=25_aUC9Om4I9zGrLxH7BgvXKma8vhKO