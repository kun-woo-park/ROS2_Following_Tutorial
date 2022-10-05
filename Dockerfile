# set initial nvidia docker image
FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04

RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64/7fa2af80.pub

# set initial arguments
ARG DEBIAN_FRONTEND=noninteractive 
ENV TZ=Asia/Seoul

# install initial packages 
RUN apt-get update
RUN apt-get upgrade

RUN apt-get install -y \
        sudo \
        vim \
        apt-utils \
        language-pack-en-base \
        build-essential \
        gcc-multilib \
        git \
        unzip \
        wget \
        iputils-ping \
        net-tools \
        ssh \
        iproute2 \
        locales \
        rename \
        zip \
        clang \
        cmake \
        debianutils \
        net-tools \
        libjansson-dev \
        tzdata \
        python3-git \
        python3-jinja2 \
        python3-venv \
        python3 \
        python3-crypto \
        python3-pip \
        python3-pexpect \
        libgl1-mesa-glx \
	      libpython3.8-dev \
	      python3-dev 
        
RUN apt install curl gnupg2 lsb-release

RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu focal main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

        
RUN apt update && apt-get install -y \
        libbullet-dev \
        python3-colcon-common-extensions \
        python3-flake8 \
        python3-pip \
        python3-pytest-cov \
        python3-rosdep \
        python3-setuptools \
        python3-vcstool

RUN pip install argcomplete \
                flake8-blind-except \
                flake8-builtins \
                flake8-class-newline \
                flake8-comprehensions \
                flake8-deprecated \
                flake8-docstrings \
                flake8-import-order \
                flake8-quotes \
                pytest-repeat \
                pytest-rerunfailures \
                pytest

RUN pip install torch==1.10.1+cu111 \
                torchvision==0.11.2+cu111 \
                torchaudio==0.10.1 -f https://download.pytorch.org/whl/torch_stable.html
                
RUN sudo apt install --no-install-recommends -y \
                libasio-dev \
                libtinyxml2-dev \
                libcunit1-dev

# Set up a locale for the python 3 version of bitbake
RUN echo 'LANG="en_US.UTF-8"'>/etc/default/locale \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8
