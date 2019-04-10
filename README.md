# Docker file for Raspberry cross-compiler environment

## Description
Basic Dockerfile based on the elements required in https://www.raspberrypi.org/documentation/linux/kernel/building.md to build the Raspberry kernel.

## Contents
The scripts are provided for convenience only:
- build.sh: builds the docker image, calling it rpi-devel
- launch.sh: runs the image in docker with a bash on stdin

## How to use on macOS
Since macOS default filesystem is not case-sensitive and the kernel repository requires that, the easiest way is to create a dmg file with the right format:
- Open Disk Utility
- File > New Image > Blank Image
- Select Mac OS Extended (Case-sensitive, Journaled)
- Mount the dmg in macOS


By default in Docker, the directory /Volumes is shared with the virtual machines, so normally there is nothing to do for that. To check, on the Docker icon, select Preferences, File Sharing, and /Volumes should be in the list.


Build the docker imagem go to the directory where the Dockerfile is located and:

```
docker build . -t rpi-devel:0.0
```

(or execute build.sh)

Run the image with stdin linked to the terminal:

```
docker run -it rpi-devel:0.0 /bin/bash
```

(or execute launch.sh)

In the new shell, follow the procedure described on raspberrypi.org (link provided above), so as of today:
```
cd /mnt/<label_of_dmg>
git clone --depth=1 https://github.com/raspberrypi/linux
cd linux
KERNEL=kernel7
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcmrpi_defconfig
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs
```
