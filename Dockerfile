#from kaixhin/vnc

# Start with Ubuntu base image
FROM ubuntu:14.04
MAINTAINER Soichi Hayashis <hayashis@iu.edu>

EXPOSE 5900

# Install LXDE, VNC server, XRDP
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
   xvfb x11vnc vim \
   lxde-core lxde-icon-theme lxterminal

#https://github.com/scilus/fibernavigator/wiki/Ubuntu-build-instructions
RUN apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:george-edison55/cmake-3.x && apt-get update && apt-get install -y g++ build-essential cmake cmake-qt-gui libgtk-3-dev libglew-dev freeglut3-dev zlib1g-dev libwxgtk3.0-dev git

#build fibernavigator
RUN git clone https://github.com/scilus/fibernavigator.git
RUN cd fibernavigator && cmake src && make

#install fslview
#RUN \
#	echo "deb http://neuro.debian.net/debian data main" >> /etc/apt/sources.list.d/neurodebian.sources.list && \
#	echo "deb http://neuro.debian.net/debian trusty main" >> /etc/apt/sources.list.d/neurodebian.sources.list && \
#	apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 0xA5D32F012649A5A9 && \
#	apt-get update && apt-get install -y fslview

# Copy VNC script that handles restarts
ADD vnc.sh /opt
CMD ["/opt/vnc.sh"]

# Install autostart file for fslview
RUN mkdir -p /root/.config/autostart
ADD start.sh /
ADD start.desktop /root/.config/autostart

