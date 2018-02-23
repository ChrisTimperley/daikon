FROM ubuntu:16.04

ENV DAIKONDIR /opt/daikon
WORKDIR /opt/daikon

ADD Makefile Makefile
ADD doc doc
ADD examples examples
ADD front-end front-end
ADD scripts scripts
ADD java java
ADD tools tools

RUN apt-get update && \
    apt-get install -y  openjdk-8-jdk \
                        build-essential \
                        gcc \
                        ctags \
                        graphviz \
                        netpbm \
                        texlive \
                        texinfo \
                        m4 \
                        automake \
                        autoconf \
                        binutils-dev \
                        git \
                        libz-dev

ENV JAVA_HOME /usr/lib/jvm/java
ENV PATH /tmp/daikon/scripts:${PATH}

RUN make compile && \
    make compile-java && \
    make kvasir
