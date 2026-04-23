# **ComfyUI RTX5090 - Docker**

> **Note**
> This docker container is mainly for RTX 5090 but is compatible with GPUs that support cuda 12.x.

This guide walks you through the **installation, configuration, and optimization** of your **ComfyUI Docker environment**, ensuring easy **model management** and **GPU acceleration**.

## **📂 Project Directory Structure**
```
comfyui-rtx5090/
│── Dockerfile            # Defines container setup
│── docker-compose.yaml   # Manages services & mounts
│── comfyui_models/       # Separate folder for models
│── comfyui_output/       # Separate folder for output
```

---

## **🛠 Step 1: Install Dependencies**
Make sure you have:
✅ **Docker** (Install from [Docker’s website](https://docs.docker.com/get-docker/))  
✅ **Docker Compose** (Comes with Docker Desktop or install separately)  
✅ **GPU Drivers** (Ensure compatibility with **CUDA 12.x**)

---

## **📥 Step 2: Clone the Repository**
Navigate to your workspace and clone the setup:
```bash
git clone https://github.com/Connortp0/comfyui-rtx5090.git
cd comfyui-rtx5090
```

---

## **⚙️ Step 3: Configure Docker & Models**
### **A. Setting Up the Container**
Your **`docker-compose.yaml`** separates application files and models:
NOTE: Modifying the **`docker-compose.yaml`** file is not recommended unless you understand what most of it does.

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
Building takes about 15-30 minutes depending on your pc and internet connection as it downloads and builds.
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

## **📖 Additional Resources**
🔹 [ComfyUI Wiki](https://comfyui-wiki.com/en/)  
🔹 [Docker Documentation](https://docs.docker.com/)  
🔹 [Civitai Models](https://civitai.com/)  