############################################################
# Dockerfile to build Nginx Installed Containers
# Based on Ubuntu
############################################################


# Set the base image to Ubuntu
FROM ubuntu:22.04

# File Author / Maintainer
MAINTAINER Karthik Gaekwad

# Install Nginx

# Add application repository URL to the default sources
# RUN echo "deb http://archive.ubuntu.com/ubuntu/ raring main universe" >> /etc/apt/sources.list

# Update the repository
RUN apt-get update

# Install necessary tools
RUN apt-get install -y vim wget dialog net-tools

RUN apt-get install -y nginx

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD nginx.conf /etc/nginx/

RUN mkdir /etc/nginx/logs

# Add a sample index file
ADD index.html /www/data/

# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Create a runner script for the entrypoint
COPY runner.sh /runner.sh
RUN chmod +x /runner.sh

# Expose ports
EXPOSE 80

ENTRYPOINT ["/runner.sh"]

# Set the default command to execute
# when creating a new container
CMD ["nginx"]