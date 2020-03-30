FROM helixious86/nodejs_base_image:latest
USER root

# Arguments that may be overridden by the user
ARG release=latest

# Install required packages
RUN apt-get update

# Install CDT & EOS from deb package
ADD install_deb.sh /
RUN chmod +rx install_deb.sh && ./install_deb.sh $release && rm -f install_deb.sh

# build system contracts
ADD build_contracts.sh /
RUN chmod +rx build_contracts.sh && ./build_contracts.sh && rm -f build_contracts.sh

ENTRYPOINT service ssh restart && bash