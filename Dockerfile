FROM helixious86/nodejs_base_image:latest
RUN sudo apt-get update
RUN mkdir -p /contracts
RUN cd / && wget https://github.com/eosio/eosio.cdt/releases/download/v1.6.3/eosio.cdt_1.6.3-1-ubuntu-18.04_amd64.deb \
&& sudo apt install ./eosio.cdt_1.6.3-1-ubuntu-18.04_amd64.deb -y \
&& rm -rf ./eosio.cdt_1.6.3-1-ubuntu-18.04_amd64.deb
RUN cd / && git clone https://github.com/EOSIO/eosio.contracts.git eosio.contracts-1.8.x \
&& cd ./eosio.contracts-1.8.x \
&& git checkout release/1.8.x \
&& rm -rf build \
&& ./build.sh -y \
&& cp /eosio.contracts-1.8.x/build/contracts/. /contracts/eosio.old -a \
&& rm -rf /eosio.contracts-1.8.x 
RUN cd / && wget https://github.com/EOSIO/eosio.cdt/releases/download/v1.7.0/eosio.cdt_1.7.0-1-ubuntu-18.04_amd64.deb \
&& sudo apt install -y ./eosio.cdt_1.7.0-1-ubuntu-18.04_amd64.deb \
&& rm -rf ./eosio.cdt_1.7.0-1-ubuntu-18.04_amd64.deb
RUN cd / && git clone https://github.com/EOSIO/eosio.contracts.git \
&& cd ./eosio.contracts/ \
&& rm -rf build \
&& ./build.sh -y \
&& cp /eosio.contracts/build/contracts/. /contracts/eosio.latest -a \
&& rm -rf /eosio.contracts
RUN cd / && wget https://github.com/eosio/eos/releases/download/v2.0.4/eosio_2.0.4-1-ubuntu-18.04_amd64.deb \
&& sudo apt install -y ./eosio_2.0.4-1-ubuntu-18.04_amd64.deb \
&& rm -rf ./eosio_2.0.4-1-ubuntu-18.04_amd64.deb
ENTRYPOINT service ssh restart && bash