# Secrets being cached within
FROM ubuntu as intermediate
# install git
RUN apt-get update
RUN apt-get install -y git
RUN mkdir /srv/avatarify
RUN git clone https://github.com/bijanmmarkes/avatarify.git /srv/avatarify
RUN cd /srv/avatarify && git checkout master
# Use the Latest LTS Ubuntu Distro
FROM ubuntu:18.04
ENV TERM xterm
# SSH server is used for keeping the applications running through the startup script.
RUN apt-get -q update
# Install the essentials and ssh-server, logging, etc.
RUN apt-get install -y openssh-server build-essential curl rsync logrotate
# Required to keep the SSH-agent running and installed properly.
RUN mkdir /var/run/sshd
# Install Apache with modules then clear apt source.lists
RUN apt-get update && apt-get install -y software-properties-common apt-utils language-pack-en-base curl && apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Install Python 3.8
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt-get install python3.7 -y
RUN python3.7 -v
# Copy latest github release of avatarify
COPY --from=intermediate /srv/avatarify /srv/avatarify
# Use the master root as the workdir
WORKDIR /srv/avatarify
# Install miniconda to /miniconda
RUN curl -LO http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN /bin/bash -x Miniconda3-latest-Linux-x86_64.sh -p /srv/avatarify/conda -b
RUN rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH=/srv/avatarify/conda/bin:${PATH}
RUN conda update -y conda
# Python packages from conda
RUN conda install -c anaconda -y python=3.8
# Download the tar file using download_data
RUN /bin/bash -x scripts/download_data.sh
RUN apt-get install -y git
# Install all the required packages for Avatarify
RUN /bin/bash -x Docker/scripts/install.sh
# Add the startup script
ADD docker-startup.sh /
# Run the startup script
CMD ["/docker-startup.sh"]
