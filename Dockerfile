FROM nvidia/cuda:12.4.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

# System dependencies
RUN apt-get update && apt-get install -y \
    git python3 python3-pip python3-venv build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

WORKDIR /app/ComfyUI

# Create virtual environment
RUN python3 -m venv venv
ENV PATH="/app/ComfyUI/venv/bin:$PATH"

# Upgrade pip
RUN pip install --upgrade pip setuptools wheel

# Install ComfyUI dependencies FIRST
RUN pip install -r requirements.txt

# Install PyTorch NIGHTLY with CUDA 12.4 (supports RTX 5090)
RUN pip install --upgrade --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu124

# Install ComfyUI Manager
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager.git /app/ComfyUI/custom_nodes/ComfyUI-Manager

EXPOSE 8188

CMD ["python3", "main.py", "--listen", "0.0.0.0"]
