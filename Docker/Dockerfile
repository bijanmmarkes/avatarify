# Use the Latest LTS Ubuntu Distro
FROM ubuntu:18.04
ENV TERM xterm
# SSH server is used for keeping the applications running through the startup script.
RUN apt-get -q update
# Install the essentials and ssh-server, logging, etc.
RUN apt-get install -y openssh-server build-essential curl v4l2loopback-dkms git
# Required to keep the SSH-agent running and installed properly.
RUN mkdir /var/run/sshd
# Install Apache with modules then clear apt source.lists
RUN apt-get update && apt-get install -y software-properties-common apt-utils language-pack-en-base curl && apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Install Python 3.8
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt-get install python3.7 -y
RUN python3.7 -v
ADD https://api.github.com/repos/bijanmmarkes/avatarify/git/refs/heads/dockerize-#7 version.json
RUN git clone https://github.com/bijanmmarkes/avatarify.git /srv/avatarify
RUN cd /srv/avatarify && git checkout dockerize-#7
# Use the master root as the workdir
WORKDIR /srv/avatarify
# Install miniconda to /miniconda
RUN curl -LO http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN /bin/bash -x Miniconda3-latest-Linux-x86_64.sh -p /srv/avatarify/conda -b
RUN rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH=/srv/avatarify/conda/bin:${PATH}
RUN conda update -y conda
# Python packages from conda
RUN conda install -c anaconda -y python=3.7
# Download the tar file using download_data
RUN /bin/bash -x scripts/download_data.sh
# Instll CUDA
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
RUN mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
RUN add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /"
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install lightdm -y
RUN apt-get -y install keyboard-configuration cuda
RUN apt-get -y install aptitude
RUN aptitude install -y v4l2loopback-source module-assistant
RUN module-assistant auto-install v4l2loopback-source -y
# Install all the required packages for Avatarify
RUN /bin/bash -x Docker/scripts/install.sh
# Add the startup script
ADD docker-startup.sh /
# Run the startup script
CMD ["/docker-startup.sh"]
