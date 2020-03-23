FROM helixious86/ubuntu_base_image:latest
RUN apt-get update -y && apt-get install -y \
    g++ \
    gcc \
    make
RUN apt upgrade -y
RUN wget https://github.com/EOSIO/eos/releases/download/v2.0.0/eosio_2.0.0-1-ubuntu-18.04_amd64.deb
RUN sudo apt install -y ./eosio_2.0.0-1-ubuntu-18.04_amd64.deb
RUN wget https://github.com/EOSIO/eosio.cdt/releases/download/v1.6.3/eosio.cdt_1.6.3-1-ubuntu-18.04_amd64.deb
RUN sudo apt install ./eosio.cdt_1.6.3-1-ubuntu-18.04_amd64.deb
ENTRYPOINT service ssh restart && bash