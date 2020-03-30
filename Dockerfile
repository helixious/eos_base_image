FROM helixious86/nodejs_base_image:latest
USER root

# Arguments that may be overridden by the user
ARG release=latest

# Install required packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssl ca-certificates curl wget && rm -rf /var/lib/apt/lists/*

# Install CDT & EOS from deb package
ADD install_deb.sh /
RUN /install_deb.sh $release && rm -f install_deb.sh

# build system contracts
ADD build_contracts.sh /
RUN /build_contracts.sh && rm -f build_contracts.sh

ENTRYPOINT service ssh restart && bash