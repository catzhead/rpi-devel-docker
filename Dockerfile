FROM debian:stretch-slim

RUN apt-get update

RUN apt-get -y upgrade

# build-essential is for make
RUN apt-get install -y git bc bison flex libssl-dev build-essential vim

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

# *************************************************************************
# qemu
# *************************************************************************

# qemu from source, because only qemu 2.12+ supports rpi3 emulation and
# as the writing of this file, debian is still on 2.8
ENV QEMU_SRC_DIR=/home/qemu

RUN apt-get install -y python zlib1g-dev pkg-config libglib2.0-dev libpixman-1-dev

RUN git clone --branch v3.0.1 https://git.qemu.org/git/qemu.git $QEMU_SRC_DIR

RUN cd $QEMU_SRC_DIR && git submodule init && git submodule update --recursive && ./configure && make && make install
