FROM ghcr.io/r-lib/rig/ubuntu-24.04-release:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install curl git fonts-ipaexfont build-essential clang libomp-dev -y

# ARG USERNAME=dockeruser
# RUN useradd ${USERNAME} --create-home
# USER ${USERNAME}

## R Install ##
WORKDIR /tmp/r-venv
RUN rig add 4.4.1 && rig run -e 'pak::pkg_install("languageserver")'

## Python Install ##
WORKDIR /tmp/python-venv

### Using Rye ###
# RUN curl -sSf https://rye-up.com/get | RYE_NO_AUTO_INSTALL=1 RYE_INSTALL_OPTION="--yes" bash
# # ENV RYE_PATH=/home/${USERNAME}/.rye/shims
# ENV RYE_PATH=/root/.rye/shims
# ENV PATH=${RYE_PATH}:${PATH}
# RUN --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
#     --mount=type=bind,source=.python-version,target=.python-version \
#     rye sync --no-dev

### Using uv ###
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
# ENV UV_PATH=/home/${USERNAME}/.cargo/bin
ENV UV_PATH=/root/.cargo/bin
ENV PATH=${UV_PATH}:${PATH}
ENV UV_PROJECT_ENVIRONMENT=/tmp/python-venv/.venv
RUN uv python install 3.12.2
RUN uv venv --python 3.12.2 && . .venv/bin/activate

### GPU Version ###
# FROM nvidia/cuda:12.3.2-devel-ubuntu22.04
# RUN apt install python3.10 python3-pip -y
# RUN --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
#     python3.10 -m pip install -e .

## Install Packages ##
RUN --mount=type=bind,source=install.R,target=install.R \
    rig run --script install.R
RUN --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --no-dev

ENTRYPOINT [ "/bin/bash" ]
