FROM node:0.12
MAINTAINER Igor Mukhin <igor.mukhin@web-dienstleister.de>

ENV IFRAMELY_VERSION=0.9.1

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