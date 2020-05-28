FROM helixious86/ubuntu_base_image:latest
USER root

# Arguments that may be overridden by the user
ARG cdt_release=latest
ARG eos_release=latest

# Install required packages
RUN apt-get update && apt install libusb-1.0-0

# Install CDT & EOS from deb package
ADD install_deb.sh /
RUN chmod +rx install_deb.sh && ./install_deb.sh $cdt_release $eos_release && rm -f install_deb.sh

# build system contracts
ADD build_contracts.sh /
RUN chmod +rx build_contracts.sh

# ENTRYPOINT service ssh restart && bash