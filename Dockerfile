FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

MAINTAINER satyender <satyenderyadav4993@gmail.com>

WORKDIR /sources

RUN apt-get update && apt-get install -y --no-install-recommends \
	build-essential \
	cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev \
	python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev \
        curl \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python3 \
        python3-dev \
        rsync \
        software-properties-common \
        unzip \
	python3-pip \
	python3-setuptools \
	wget \
        && \
apt-get clean

RUN pip3 install numpy

RUN wget https://github.com/opencv/opencv/archive/3.3.0.tar.gz

RUN tar -xvzf 3.3.0.tar.gz
RUN rm 3.3.0.tar.gz

RUN wget https://github.com/opencv/opencv_contrib/archive/3.3.0.tar.gz 

RUN tar -xvzf 3.3.0.tar.gz
RUN rm 3.3.0.tar.gz

RUN mkdir build
WORKDIR /sources/build

RUN cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=../opencv_contrib-3.3.0/modules ../opencv-3.3.0

RUN make -j4 && make install

WORKDIR /workspace

RUN rm -rf /sources

RUN pip3 install tensorflow

RUN pip3 install keras

# h5py is optional dependency for keras
# RUN apt-get update && apt-get install -y libhdf5-dev libhdf5-serial-dev
# RUN pip install keras h5py

RUN chmod -R a+w /workspace

