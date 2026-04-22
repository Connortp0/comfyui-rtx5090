FROM nvidia/cuda:12.1.1-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

# System dependencies
RUN apt-get update && apt-get install -y \
    git python3 python3-pip python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Create workspace
WORKDIR /app

# Clone ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

WORKDIR /app/ComfyUI

# Create virtual environment
RUN python3 -m venv venv
ENV PATH="/app/ComfyUI/venv/bin:$PATH"

# Install PyTorch (CUDA 12.1)
RUN pip install --upgrade pip && \
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# Install ComfyUI dependencies
RUN pip install -r requirements.txt

# Install ComfyUI Manager
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager.git /app/ComfyUI/custom_nodes/ComfyUI-Manager

# Expose ComfyUI port
EXPOSE 8188

# Run ComfyUI
CMD ["python3", "main.py", "--listen", "0.0.0.0"]
