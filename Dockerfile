FROM docker.io/bitnami/pytorch:latest AS builder

USER root

# Set environment variables
ARG USER=xplain

ENV USER ${USER}
ENV HOME /home/${USER}

# Install GCC with C++11 support
RUN echo "deb http://deb.debian.org/debian testing main contrib non-free" >> /etc/apt/sources.list
RUN apt-get update -y
RUN apt-get install -y build-essential
RUN apt install -y -t testing gcc-11

# Make sure the contents of our repo is in $HOME
COPY requirements.txt $HOME/

# Set working directory
WORKDIR ${HOME}

# Upgrade pip
RUN python3 -m pip install --no-cache-dir --upgrade pip
# Install and build packages in ~/.local
RUN python3 -m pip install --no-cache-dir --user -r requirements.txt 


FROM docker.io/bitnami/pytorch:latest

USER root

# Set environment variables
ARG USER=xplain
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV USER ${USER}
ENV HOME /home/${USER}

# Create user
RUN groupadd --gid $USER_GID $USER && useradd --uid $USER_UID --gid $USER_GID -m $USER

# Install generic GL provider and glib
RUN apt-get update -y
RUN apt-get install -y libgl1-mesa-glx libglib2.0-0
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR ${HOME}

COPY --from=builder --chown="${USER_UID}:${USER_GID}" $HOME/.local ./.local/

# Upgrade pip
RUN python3 -m pip install --no-cache-dir --upgrade pip

ENV JUPYTER_PORT=8888
EXPOSE ${JUPYTER_PORT}

# Make sure scripts in .local are usable:
ENV PATH=/home/xplain/.local/bin:$PATH

USER ${USER}

CMD ["jupyter", "lab", "--ip",  "0.0.0.0", "--port", "8888", "--no-browser", "--allow-root"]
