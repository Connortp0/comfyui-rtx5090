# **ComfyUI RTX5090 - Docker**

This guide walks you through the **installation, configuration, and optimization** of your **ComfyUI Docker environment**, ensuring easy **model management** and **GPU acceleration**.

## **📂 Project Directory Structure**
```
comfyui-rtx5090/
│── Dockerfile            # Defines container setup
│── docker-compose.yaml   # Manages services & mounts
│── comfyui_data/         # Contains ComfyUI application files
│── comfyui_models/       # Separate folder for models
```

---

## **🛠 Step 1: Install Dependencies**
Make sure you have:
✅ **Docker** (Install from [Docker’s website](https://docs.docker.com/get-docker/))  
✅ **Docker Compose** (Comes with Docker Desktop or install separately)  
✅ **GPU Drivers** (Ensure compatibility with **CUDA 12.8**)

---

## **📥 Step 2: Clone the Repository**
Navigate to your workspace and clone the setup:
```bash
git clone https://github.com/YOUR_USERNAME/comfyui-rtx5090.git
cd comfyui-rtx5090
```

---

## **⚙️ Step 3: Configure Docker & Models**
### **A. Setting Up the Container**
Your **`docker-compose.yaml`** separates application files and models:
NOTE: Modifying the **`docker-compose.yaml`** file is not recommended unless you understand what most of it does.
```yaml
version: '3.8'
services:
  comfyui:
    build:
      context: ./comfyui_data  # Stores ComfyUI container files
      dockerfile: ../Dockerfile
    image: comfyui-rtx5090
    ports:
      - "8188:8188"
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              capabilities: [gpu]
    volumes:
      - ./comfyui_models:/ComfyUI/models  # Models are stored separately
    command: ["/venv/bin/python", "main.py", "--listen", "0.0.0.0"]
```

### **B. Organizing Models**
Create a dedicated model directory:
```bash
mkdir comfyui_models
mkdir comfyui_models/checkpoints comfyui_models/vae comfyui_models/loras
```
Place your models inside:
```
comfyui_models/
├── checkpoints/      # Base models (SDXL, Stable Diffusion, etc.)
├── vae/              # Variational Autoencoders
├── loras/            # LoRA models for fine-tuning styles
```

---

## **🚀 Step 4: Build & Run the Container**
Building takes about 15-30 minutes depending on your pc and internet connection as it downloads about 35GB of data.
Now, deploy ComfyUI with Docker:
```bash
docker-compose up --build -d
```
✅ **ComfyUI will be accessible at:** [`http://localhost:8188`](http://localhost:8188)  
✅ **Models will be loaded automatically from `comfyui_models/`**   

---

## **🔄 Step 5: Updating & Managing Models**
### **A. Adding New Models**
Simply place new models into their respective folders:
```bash
mv new_model.safetensors comfyui_models/checkpoints/
```
Restart the container to load them:
```bash
docker-compose restart comfyui
```

### **B. Updating ComfyUI**
To pull the latest updates while keeping your models intact:
```bash
docker-compose pull
docker-compose up --build -d
```

---

## **⚙️ Step 6: Optimizing Your Setup**
- **Modify workflows** → Drag & drop `.json` or `.png` files into ComfyUI  
- **Fine-tune prompts** → Adjust LoRA weights & refine descriptions  
- **Enhance performance** → Tune `--listen` and `--port` settings  

---

## **📖 Additional Resources**
🔹 [ComfyUI Wiki](https://comfyui-wiki.com/en/)  
🔹 [Docker Documentation](https://docs.docker.com/)  
🔹 [Civitai Models](https://civitai.com/)  