FROM debian:stretch-slim

RUN apt-get update

RUN apt-get -y upgrade

# build-essential is for make
RUN apt-get install -y git bc bison flex libssl-dev build-essential vim qemu

# bash customization
RUN echo PS1=\'\>\> [\\T] \\w \\$ \' >> ~/.bashrc
RUN echo alias ls=\'ls --color\' >> ~/.bashrc

# *************************************************************************
# raspberry gcc
# *************************************************************************

# the default user is root, but it seems cleaner to put the tools in home
ENV RPI_TOOLS_DIR=/home/rpi-tools

# raspberry gcc cross-compiler
RUN git clone https://github.com/raspberrypi/tools $RPI_TOOLS_DIR

# add the path to the compiler in PATH, because make expects it in the kernel source repo
RUN echo PATH=\$PATH:$RPI_TOOLS_DIR/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin >> ~/.bashrc
