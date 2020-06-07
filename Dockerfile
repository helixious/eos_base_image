# FROM helixious86/ubuntu_base_image:latest
FROM helixious86/eos_base_image:centos7.v1.1.1
# FROM eostudio/eosio.cdt:v1.7.0
USER root
# ARG cdt_release=v1.6.3
# ARG eos_release=latest
# ARG contract_release=release/1.8.x

# RUN yum update -y \    
#     && curl -sL https://rpm.nodesource.com/setup_14.x | bash - \
#     && yum install -y nodejs \
#     && yum clean all && yum makecache fast

# RUN rm -rf install_deb.sh anaconda-post.log

# ADD init.sh /
RUN mkdir -p /data/blockchain && mkdir -p /data/blockchain/$HOSTNAME
# RUN chmod +x /init.sh

# docker run -e "EOS_VERSION=latest" -e "CONTRACT_VERSION=release/1.8.x" -e "CDT_VERSION=v1.6.3" --rm -ti helixious86/eos_base_image:centos7.v1.1
# RUN chmod +x install_deb.sh && ./install_deb.sh $cdt_release $eos_release $contract_release && rm -f install_deb.sh