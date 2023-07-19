FROM ubuntu:20.04 AS builder

WORKDIR /blockchain

RUN apt-get update 

RUN mkdir geth
COPY ./geth-1.11.6.tar.gz ./geth
RUN tar -xvzf ./geth/geth-1.11.6.tar.gz && mkdir /geth-1.11.6
RUN cp ./geth-linux-amd64-1.11.6-ea9e62ca/* /geth-1.11.6/geth && rm -rf *

ENV PATH="$PATH:/geth-1.11.6"
RUN echo "export PATH=$PATH:/geth-1.11.6" >> ~/.bashrc

COPY ./genesis.json ./

RUN geth --datadir . init genesis.json

ENTRYPOINT ["geth"]