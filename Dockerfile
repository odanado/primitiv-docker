ARG cuda_version=8.0
ARG cudnn_version=5
FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-devel-ubuntu16.04

RUN apt update && apt upgrade -y && \
    apt install -y ca-certificates git g++ make cmake --no-install-recommends && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN git clone https://github.com/primitiv/primitiv /src/primitiv

WORKDIR /src/primitiv

RUN mkdir build && cd build && \
    cmake .. -DPRIMITIV_USE_CUDA=ON && \
    make -j 4 && \
    make install && \
    make clean && \
    ldconfig
