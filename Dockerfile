FROM sitespeedio/node:ubuntu-20.04-nodejs-14.17.6

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ccache \
    cmake \
    ninja-build \
    pkg-config \
    xvfb \
    libcurl4-openssl-dev \
    libglfw3-dev \
    libuv1-dev \
    g++-10 \
    libc++-9-dev \
    libc++abi-9-dev \
    libjpeg-dev \
    libpng-dev \
    zlib1g

RUN /usr/sbin/update-ccache-symlinks
RUN mkdir /mapbox

WORKDIR /mapbox

COPY . .

# Necessary?
RUN npm i || true

RUN cmake . -B build -G Ninja -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_C_COMPILER=gcc-10 -DCMAKE_CXX_COMPILER=g++-10
RUN cmake --build build -j6