# Basic Docker commands
FROM nvidia/cudagl:10.1-devel-ubuntu16.04
LABEL maintainer=sungwon

# add user name `user` for X11 to use GUI. 
ENV USERNAME user
RUN apt-get update && \
        apt install sudo && \
        useradd -m $USERNAME && \
        echo "$USERNAME:$USERNAME" | chpasswd && \
        usermod --shell /bin/bash $USERNAME && \
        usermod -aG sudo $USERNAME && \
        echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
        chmod 0440 /etc/sudoers.d/$USERNAME && \
        # Replace 1000 with your user/group id
        usermod  --uid 1000 $USERNAME && \
        groupmod --gid 1000 $USERNAME

# install ubuntu packages for dex-net
RUN apt-get install -y \
        curl \
        python \
        python-dev \
        python-pip \
        git \
        cmake \
        libvtk5-dev \
        python-sip \
        python-qt4 \
        libosmesa6-dev \
        meshlab \
        libhdf5-dev \
        python-vtk \
        python-tk \
        libspatialindex-dev

# if need to `pip install wxPython` ==> mayavi
# sudo apt-get install build-essential libgtk-3-dev

# install additional 3rd-party package(Boost.Numpy)
RUN apt install -y \
        libboost-dev \
        libboost-all-dev
WORKDIR /etc/ld.so.conf.d
RUN echo /usr/local/lib64 >> libc.conf && \
        ldconfig
WORKDIR /home/user/ws