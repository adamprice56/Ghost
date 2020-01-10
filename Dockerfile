#
# Ghost Dockerfile
#
# https://github.com/dockerfile/ghost
#

# Pull base image.
FROM node

# Install Ghost
RUN \
  cd /tmp && \
  wget https://gitlab.com/adamprice56/Ghost/-/archive/master/Ghost-master.zip && \
  unzip Ghost-master.zip -d /ghost && \
  rm -f Ghost-master.zip && \
  cd /ghost && \
  npm install --production && \
  #sed 's/127.0.0.1/0.0.0.0/' /ghost/config.example.js > /ghost/config.js && \
  useradd ghost --home /ghost

# Add files.
ADD start.bash /ghost-start

# Set environment variables.
ENV NODE_ENV production

# Define mountable directories.
VOLUME ["/data", "/ghost-override"]

# Define working directory.
WORKDIR /ghost

# Define default command.
CMD ["bash", "/ghost-start"]

# Expose ports.
EXPOSE 2368
