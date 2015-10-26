FROM ubuntu:14.04
MAINTAINER Igor Mukhin <igor.mukhin@web-dienstleister.de>

ENV IFRAMELY_VERSION=0.9.0

# Install all the necessary packages
RUN     apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y \
		software-properties-common \
		curl \
		build-essential \
	&& curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash - \
	&& apt-get install -y nodejs \
	&& add-apt-repository -y ppa:fkrull/deadsnakes \
	&& apt-get update \
	&& apt-get install -y python2.7 \
	&& ln -s /usr/bin/python2.7 /usr/bin/python \
	&& rm -rf /var/lib/apt/lists/*

# Download Iframely
RUN mkdir -p /iframely/app \
	&& cd /iframely \
	&& curl -o iframely.tar.gz https://codeload.github.com/itteco/iframely/tar.gz/v$IFRAMELY_VERSION \
	&& tar xf iframely.tar.gz -C app --strip-components 1

WORKDIR /iframely/app

# Install Iframely dependencies
RUN npm install
   
# Use default configuration
RUN cp config.local.js.SAMPLE config.local.js

# Expose the default http port
EXPOSE 8061

# Start
CMD ["node", "cluster"]