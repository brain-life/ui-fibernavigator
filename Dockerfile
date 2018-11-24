FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04

MAINTAINER Soichi Hayashis <hayashis@iu.edu>

EXPOSE 5900
ENV DEBIAN_FRONTEND=noninteractive

# Install LXDE, VNC server, XRDP
RUN apt-get update && apt-get install -y \
   vim curl tightvncserver xfce4 mesa-utils

ADD virtualgl_2.5.2_amd64.deb /
RUN dpkg -i /virtualgl_2.5.2_amd64.deb

#https://github.com/scilus/fibernavigator/wiki/Ubuntu-build-instructions
RUN apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:george-edison55/cmake-3.x && apt-get update && apt-get install -y g++ build-essential cmake cmake-qt-gui libgtk-3-dev libglew-dev freeglut3-dev zlib1g-dev libwxgtk3.0-dev git

#build fibernavigator
RUN git clone https://github.com/scilus/fibernavigator.git /fibernavigator
RUN cd /fibernavigator && cmake src && make

RUN apt-get install -y wmctrl 

ADD startvnc.sh /
ADD xstartup /root/.vnc/xstartup
ENV USER=root X11VNC_PASSWORD=override

CMD ["/startvnc.sh"]
