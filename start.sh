#!/bin/bash
COMFYUI_DIR="/ComfyUI_data/ComfyUI"
LOG_FILE="/ComfyUI_data/start.log"

# Start logging
echo "===== Startup Started: $(date) =====" | tee -a "$LOG_FILE"

# Check if ComfyUI is installed
if [ ! -f "$COMFYUI_DIR/main.py" ]; then
    echo "ComfyUI missing! Running setup..." | tee -a "$LOG_FILE"
    bash /setup.sh | tee -a "$LOG_FILE"  # Call setup.sh and log output
fi

# Start ComfyUI
echo "Starting ComfyUI..." | tee -a "$LOG_FILE"
exec /venv/bin/python "$COMFYUI_DIR/main.py" --listen 0.0.0.0 | tee -a "$LOG_FILE"

echo "===== Startup Completed: $(date) =====" | tee -a "$LOG_FILE"