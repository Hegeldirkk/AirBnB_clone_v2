#!/bin/bash
# Write a Bash script that sets up your web servers for the deployment of web_static
apt-get -y update
apt-get -y install nginx
mkdir -p /data/
mkdir -p /data/web_static/
mkdir -p /data/web_static/releases/
mkdir -p /data/web_static/shared/
mkdir -p /data/web_static/releases/test/

# Create a fake HTML file
echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" >> /data/web_static/releases/test/index.html

#Create a symbolic link
ln -f -s /data/web_static/current /data/web_static/releases/test/

# ownership of the /data/ folder to the ubuntu user AND group
chwod -R ubuntu:ubuntu /data/

#Update the Nginx configuration to serve the content 
sed -i "\t location /hbnb_static/ {\n\t\t alias /data/web_static/current/hbnb_static/;\n\t\t autoindex off; \n\t }"

#restart serveur
service nginx restart
