ARG FROM_IMG_REGISTRY=docker.io
ARG FROM_IMG_REPO=qnib
ARG FROM_IMG_NAME="uplain-cuda-devel"
ARG FROM_IMG_TAG="latest"
ARG FROM_IMG_HASH=""
FROM ${FROM_IMG_REGISTRY}/${FROM_IMG_REPO}/${FROM_IMG_NAME}:${FROM_IMG_TAG}${DOCKER_IMG_HASH}

ENV CUDNN_VERSION=7.0.5.15-1+cuda9.0
ENV NCCL_VERSION=2.2.12-1+cuda9.0

# Python 2.7 or 3.5 is supported by Ubuntu Xenial out of the box
ARG python=2.7
ENV PYTHON_VERSION=${python}

RUN echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends --allow-downgrades \
        build-essential \
        cmake \
        git \
        curl \
        vim \
        wget \
        ca-certificates \
        libcudnn7=${CUDNN_VERSION} \
        libnccl2=${NCCL_VERSION} \
        libnccl-dev=${NCCL_VERSION} \
        libjpeg-dev \
        libpng-dev \
        python${PYTHON_VERSION} \
        python${PYTHON_VERSION}-dev

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py
