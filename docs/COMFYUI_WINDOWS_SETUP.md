# ComfyUI Windows Setup Guide

Complete setup for Windows PC with pixel art generation.

---

## 📋 Prerequisites

- **Windows 10/11** (64-bit)
- **RAM**: 8GB+ recommended
- **Disk**: 20GB+ free space for models
- **GPU** (optional): NVIDIA recommended (AMD/Intel supported)

---

## 🚀 Option 1: Portable Windows Version (EASIEST)

### Step 1: Download Portable ComfyUI
1. Go to: https://github.com/comfyanonymous/ComfyUI/releases
2. Find the latest release
3. Download `portable_windows_[version].7z` or `.zip`
4. Extract to a folder (e.g., `C:\ComfyUI`)

### Step 2: Download Model
1. Create folder: `C:\ComfyUI\models\checkpoints`
2. Download Stable Diffusion 1.5 model:
   - Go to: https://huggingface.co/runwayml/stable-diffusion-v1-5
   - Download `v1-5-pruned-emaonly.safetensors` (~4GB)
   - Place in `C:\ComfyUI\models\checkpoints\`

### Step 3: Run ComfyUI
1. Open `C:\ComfyUI\`
2. Double-click `run_nvidia_gpu.bat` (if you have NVIDIA GPU)
   - OR `run_cpu.bat` (if no GPU)
   - OR `run_amd_gpu.bat` (if you have AMD GPU)
3. Wait for terminal to show:
   ```
   To see the GUI go to: http://127.0.0.1:8188
   ```
4. Open browser: http://127.0.0.1:8188 ✅

**That's it!** The portable version handles everything.

---

## 🎨 Option 2: GitHub Version (More Control)

### Step 1: Install Prerequisites
1. **Install Python 3.10+**:
   - Download from: https://www.python.org/downloads/
   - Make sure to check "Add Python to PATH" during install
   - Verify: Open Command Prompt, type `python --version`

2. **Install Git**:
   - Download from: https://git-scm.com/download/win
   - Use default options during install

### Step 2: Clone ComfyUI
1. Open Command Prompt
2. Navigate to where you want ComfyUI:
   ```cmd
   cd C:\
   ```
3. Clone repository:
   ```cmd
   git clone https://github.com/comfyanonymous/ComfyUI.git
   cd ComfyUI
   ```

### Step 3: Create Virtual Environment
```cmd
python -m venv venv
venv\Scripts\activate
```

You should see `(venv)` prefix in command prompt.

### Step 4: Install Dependencies
```cmd
pip install -r requirements.txt
```

### Step 5: Download Model
```cmd
mkdir models\checkpoints
cd models\checkpoints
```

Then download `v1-5-pruned-emaonly.safetensors` from:
https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.safetensors

Save it to `C:\ComfyUI\models\checkpoints\`

### Step 6: Run ComfyUI
```cmd
cd C:\ComfyUI
venv\Scripts\activate
python main.py --normalvram
```

Then open: http://127.0.0.1:8188

---

## 🎯 Using ComfyUI on Windows

### Generate Pixel Art Assets:

1. **Start ComfyUI** (run `.bat` file or python command)
2. **Open browser**: http://127.0.0.1:8188
3. **Enter your prompt** (from `AI_GENERATION_PROMPTS.md`)

Example prompt:
```
pixel art tshirt, red color, 64x64 pixels, flat colors, no anti-aliasing,
cute aesthetic, Stardew Valley style, transparent background
```

4. **Settings**:
   - Image size: 64 (width) x 64 (height)
   - Sampler: `euler`
   - Steps: 25
   - CFG: 8

5. **Click "Queue Prompt"**
6. **Wait for generation** (~10-30 seconds depending on GPU)
7. **Image appears on right side**
8. **Right-click → Save image**

### Save Generated Images to Project:

Once you generate assets:

1. **ComfyUI saves to**: `C:\ComfyUI\output\`
2. **Copy to your project**:
   - From: `C:\ComfyUI\output\`
   - To: `~/Claude_GameDev/assets/clothing/` (or appropriate folder)

You can do this through Windows Explorer or Command Prompt:
```cmd
copy C:\ComfyUI\output\*.png "\\wsl$\Ubuntu\home\user\Claude_GameDev\assets\clothing\"
```

---

## 🖥️ GPU Optimization (Windows)

### NVIDIA GPU (Recommended)
```cmd
python main.py --normalvram
```
(Already included in `run_nvidia_gpu.bat`)

### AMD GPU
```cmd
python main.py --directml
```

### Intel GPU
```cmd
python main.py --normalvram
```

### CPU Only (Slow)
```cmd
python main.py --cpu
```

### Low on VRAM?
```cmd
python main.py --lowvram
```

---

## 🔍 Pixel Art Settings (For Best Results)

When generating in ComfyUI:

**Positive Prompt**:
```
pixel art [item], [color], [size]×[size] pixels,
flat colors, no anti-aliasing, cute aesthetic,
Stardew Valley style, transparent background
```

**Negative Prompt**:
```
anti-aliasing, blurry, gradient, smooth shading,
3D, realistic, photorealistic, smooth edges
```

**Sampler Settings**:
- Sampler: `euler` or `dpmpp_2m_karras`
- Steps: 20-30
- CFG Scale: 7-10
- Seed: Random

**Image Size**:
- Clothing/Icons: 64×64 or 48×48
- Baskets: 96×96
- Machine: 256×256
- Background: 1280×720

---

## 📚 Pixel Art Generation Examples

### T-Shirt (64×64)
```
Positive: pixel art tshirt, red color, 64x64 pixels, front view, flat colors, no anti-aliasing, cute, Stardew Valley style, transparent background
Negative: anti-aliasing, blurry, gradient, 3D, realistic
Size: 64×64
Steps: 25
CFG: 8
```

### Basket (96×96)
```
Positive: pixel art woven laundry basket, 96x96 pixels, cream color, isometric 3/4 view, flat colors, no anti-aliasing, Stardew Valley style, transparent background
Negative: anti-aliasing, blurry, gradient, realistic
Size: 96×96
Steps: 25
CFG: 8
```

### Care Icon (48×48)
```
Positive: pixel art care icon, temperature cold snowflake, 48x48 pixels, line style, minimalist, flat colors, no anti-aliasing, transparent background
Negative: filled, detailed, gradient, anti-aliasing
Size: 48×48
Steps: 20
CFG: 7
```

---

## 🚀 Batch Generation Workflow

Generate multiple assets efficiently:

1. **Open ComfyUI**: http://127.0.0.1:8188
2. **Load default workflow** or create simple one
3. **Generate first asset**, save it
4. **Change prompt**, keep same settings
5. **Queue Prompt** again
6. **Repeat** for all 43+ assets
7. **Let it run** through queue

ComfyUI will process them one by one while you do other work!

---

## ⚙️ Troubleshooting Windows

### Issue: "Python not found" or "No module named torch"
**Solution**:
1. Ensure Python is installed: `python --version`
2. Make sure virtual environment is activated (see `(venv)` prefix)
3. Reinstall requirements: `pip install -r requirements.txt`

### Issue: Out of Memory during generation
**Solution**:
```cmd
python main.py --normalvram    # Default
python main.py --lowvram        # Less VRAM usage
python main.py --cpu            # Use CPU instead
```

### Issue: Very slow first generation
**Solution**: Normal! It's downloading VAE and other components. Wait 5-10 minutes first time.

### Issue: "http://127.0.0.1:8188" won't load
**Solution**:
1. Check terminal - should show "To see the GUI go to: http://127.0.0.1:8188"
2. If not, close terminal and run again
3. Try `http://localhost:8188` instead
4. Check firewall isn't blocking port 8188

### Issue: Model download stuck
**Solution**:
1. Download manually from Hugging Face (browser)
2. Place in `C:\ComfyUI\models\checkpoints\`
3. Restart ComfyUI

### Issue: "version not available" when running .bat
**Solution**:
1. Download specific ComfyUI version from releases page
2. Or manually setup using GitHub method above

---

## 📁 Expected Folder Structure (Windows)

```
C:\ComfyUI\
├── main.py
├── run_nvidia_gpu.bat
├── run_cpu.bat
├── run_amd_gpu.bat
├── models\
│   ├── checkpoints\
│   │   └── v1-5-pruned-emaonly.safetensors
│   ├── vae\
│   └── loras\
├── output\                 (Generated images go here)
├── web\
└── custom_nodes\
```

---

## 🎯 Quick Start (Windows)

### Portable Version (Easiest):
1. Download `portable_windows.7z` from GitHub releases
2. Extract to `C:\ComfyUI`
3. Download model to `C:\ComfyUI\models\checkpoints\`
4. Double-click `run_nvidia_gpu.bat` (or `run_cpu.bat`)
5. Open http://127.0.0.1:8188
6. Generate pixel art! 🎨

### GitHub Version:
1. Install Python 3.10+
2. Install Git
3. Clone ComfyUI: `git clone https://github.com/comfyanonymous/ComfyUI.git`
4. Create venv: `python -m venv venv && venv\Scripts\activate`
5. Install deps: `pip install -r requirements.txt`
6. Download model to `models\checkpoints\`
7. Run: `python main.py --normalvram`
8. Open http://127.0.0.1:8188

---

## 🔗 Useful Links

- **ComfyUI GitHub**: https://github.com/comfyanonymous/ComfyUI
- **Stable Diffusion Model**: https://huggingface.co/runwayml/stable-diffusion-v1-5
- **ComfyUI Discord**: https://discord.gg/comfyui
- **Prompts**: Use your `AI_GENERATION_PROMPTS.md` file

---

## 💡 Tips for Windows Users

1. **Use portable version** - easiest, no Python setup needed
2. **Keep ComfyUI running** - generates while you do other work
3. **Save images frequently** - right-click image → Save
4. **Batch queue** - queue 10+ prompts, let them run overnight
5. **Keep model file** - reuse `v1-5-pruned-emaonly.safetensors`, only download once

---

**Ready?** Start with Step 1 (portable version) - easiest for Windows!
