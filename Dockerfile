FROM nvidia/cuda:12.8.0-devel-ubuntu24.04

# Install Python & dependencies
RUN apt update && apt install -y python3.12 python3-pip python3.12-venv python3-opencv libopencv-dev git curl wget

# Create virtual environment
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Install PyTorch
RUN /venv/bin/pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu128

# Copy setup and start and allow to run
COPY setup.sh /setup.sh
COPY start.sh /start.sh
RUN chmod +x /setup.sh /start.sh

# Expose Ports & Run Setup Script
EXPOSE 8188
CMD ["bash", "/start.sh"]  # Run initialization script