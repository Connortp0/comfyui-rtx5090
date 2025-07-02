#!/bin/bash
COMFYUI_DIR="/ComfyUI_data/ComfyUI"
MODELS_DIR="/ComfyUI_data/ComfyUI/models/checkpoints"
DEFAULT_MODEL_URL="https://huggingface.co/Comfy-Org/stable-diffusion-v1-5-archive/resolve/main/v1-5-pruned-emaonly-fp16.safetensors"
DEFAULT_MODEL_NAME="v1-5-pruned-emaonly-fp16.safetensors"
LOG_FILE="/ComfyUI_data/setup.log"

# Start logging
echo "===== Setup Started: $(date) =====" | tee -a "$LOG_FILE"

# Check if ComfyUI is installed
if [ ! -f "$COMFYUI_DIR/main.py" ]; then
    echo "Installing ComfyUI..." | tee -a "$LOG_FILE"
    
    # Remove incomplete ComfyUI folder if detected
    rm -rf "$COMFYUI_DIR"

    # Clone ComfyUI into comfyui_data/
    git clone https://github.com/comfyanonymous/ComfyUI.git "$COMFYUI_DIR" | tee -a "$LOG_FILE"
    cd "$COMFYUI_DIR" || exit

    # Install dependencies
    /venv/bin/pip install -r requirements.txt | tee -a "$LOG_FILE"
    echo "ComfyUI installed successfully" | tee -a "$LOG_FILE"

    # Install ComfyUI Manager
    COMFYUI_MANAGER_DIR="$COMFYUI_DIR/custom_nodes/ComfyUI-Manager"
    if [ ! -d "$COMFYUI_MANAGER_DIR" ]; then
        echo "Installing ComfyUI Manager..." | tee -a "$LOG_FILE"

        # Clone ComfyUI Manager into the custom_nodes directory
        git clone https://github.com/ltdrdata/ComfyUI-Manager.git "$COMFYUI_MANAGER_DIR" | tee -a "$LOG_FILE"

        echo "ComfyUI Manager installed" | tee -a "$LOG_FILE"
    else
        echo "ComfyUI Manager already installed. Skipping" | tee -a "$LOG_FILE"
    fi
fi

# Ensure model directory exists
mkdir -p "$MODELS_DIR" | tee -a "$LOG_FILE"

# Check if the model already exists, download if missing
if [ ! -f "$MODELS_DIR/$DEFAULT_MODEL_NAME" ]; then
    echo "Fetching model from Hugging Face..." | tee -a "$LOG_FILE"
    
    # Download model
    wget --progress=bar:force -O "$MODELS_DIR/$DEFAULT_MODEL_NAME" "$DEFAULT_MODEL_URL" | tee -a "$LOG_FILE"

    echo "Model downloaded successfully" | tee -a "$LOG_FILE"

    # Restart container after model installation
    echo "Restarting container after model installation" | tee -a "$LOG_FILE"
    exit 0
else
    echo "Model already exists. Skipping download" | tee -a "$LOG_FILE"
fi

echo "===== Setup Completed: $(date) =====" | tee -a "$LOG_FILE"