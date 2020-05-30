# FROM helixious86/ubuntu_base_image:latest
FROM helixious86/eos_base_image:centos7.v1.0
# FROM eostudio/eosio.cdt:v1.7.0
USER root
ARG cdt_release=v1.6.3
ARG eos_release=latest
ARG contract_release=release/1.8.x

RUN mkdir -p /contracts
RUN chmod +x install_deb.sh && ./install_deb.sh $cdt_release $eos_release $contract_release && rm -f install_deb.sh