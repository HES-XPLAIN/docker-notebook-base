FROM quay.io/jupyter/pytorch-notebook:cuda12-latest

USER root

# Set environment variables
ARG USER=jovyan
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV USER=${USER}
ENV HOME=/home/${USER}

# Install utilities
RUN apt update -y
RUN apt install -y git curl unzip
RUN apt clean && rm -rf /var/lib/apt/lists/*

# Make sure the contents of our repo is in $HOME
COPY requirements.txt $HOME/

# Set working directory
WORKDIR ${HOME}

# remove 'work' directory
RUN rm -rf ~/work

# Upgrade pip
RUN python3 -m pip install --no-cache-dir --upgrade pip --no-warn-script-location
# Install and build packages in ~/.local
RUN python3 -m pip install --no-cache-dir --user -r requirements.txt

# Fix permissions
RUN chown -R ${USER}:users ~/.local

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility

ENV JUPYTER_PORT=8888
EXPOSE ${JUPYTER_PORT}

# Make sure scripts in .local are usable:
ENV PATH=/home/${USER}/.local/bin:$PATH

USER ${USER}

CMD ["jupyter", "lab", "--ip",  "0.0.0.0", "--port", "8888", "--no-browser", "--allow-root"]
