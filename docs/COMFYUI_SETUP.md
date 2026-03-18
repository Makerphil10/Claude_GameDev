# ComfyUI Setup Guide for Pixel Art Generation

Complete walkthrough for setting up ComfyUI locally on Linux.

---

## 📋 Prerequisites

- **System**: Linux (you have this ✓)
- **RAM**: 8GB+ recommended (more is better)
- **Disk**: 20GB+ free space for models
- **GPU** (optional but recommended): NVIDIA, AMD, or Intel with supported drivers
- **Python**: 3.10+ (we'll check/install)

---

## 🚀 Step 1: Clone ComfyUI Repository

```bash
# Navigate to a good location (not inside your game project)
cd ~

# Clone the repository
git clone https://github.com/comfyanonymous/ComfyUI.git

# Enter directory
cd ComfyUI
```

**Expected output**: Should download ~100MB

---

## 🔧 Step 2: Create Python Virtual Environment

```bash
# Check Python version
python3 --version  # Should be 3.10+

# Create virtual environment
python3 -m venv venv

# Activate it
source venv/bin/activate

# Upgrade pip
pip install --upgrade pip
```

**Check**: When active, your terminal should show `(venv)` prefix

---

## 📦 Step 3: Install Dependencies

```bash
# Make sure you're in ComfyUI directory with venv activated
cd ~/ComfyUI
source venv/bin/activate

# Install required packages
pip install -r requirements.txt
```

**Time**: ~5-10 minutes depending on internet
**Expected**: ~500MB+ of packages installed

---

## 🎨 Step 4: Download Model (Required)

ComfyUI needs an image generation model. For pixel art, we'll use **Stable Diffusion 1.5** or **Flux**.

### Option A: Stable Diffusion 1.5 (Recommended for pixel art)

```bash
# Create models directory
mkdir -p ~/ComfyUI/models/checkpoints

# Download model (1.4GB - takes 5-10 min)
cd ~/ComfyUI/models/checkpoints
wget https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.safetensors
```

**Alternative (faster)**: If wget is slow, download manually from Hugging Face and place in `models/checkpoints/`

### Option B: Flux (Better quality, needs more VRAM)

```bash
# Only if you have 8GB+ VRAM
cd ~/ComfyUI/models/checkpoints
wget https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/flux1-schnell.safetensors
```

**Recommendation**: Start with Stable Diffusion 1.5, upgrade to Flux later if needed

---

## 🎯 Step 5: Install Custom Nodes (Optional but Useful)

Custom nodes add helpful features. Install these:

```bash
cd ~/ComfyUI/custom_nodes

# Clone useful node packs
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
git clone https://github.com/Kosinkadink/ComfyUI-Advanced-ControlNet.git
```

Then restart ComfyUI - it will auto-detect new nodes.

---

## 🖥️ Step 6: Start ComfyUI Server

```bash
# Make sure venv is activated
cd ~/ComfyUI
source venv/bin/activate

# Start server
python main.py
```

**Expected output**:
```
Starting server
To see the GUI go to: http://127.0.0.1:8188
```

**Success**: Open browser to `http://127.0.0.1:8188` - you should see the ComfyUI interface

---

## 🎨 Step 7: Test Generation (First Run)

1. **Open ComfyUI** in browser: http://127.0.0.1:8188
2. **Load default workflow**: Menu → Example → Txt2Img
3. **Enter a test prompt**:
   ```
   pixel art red tshirt, 64x64, flat colors, no anti-aliasing, transparent background
   ```
4. **Click Queue Prompt** (button in bottom right)
5. **Wait**: First run downloads VAE and other components (~2-3 min)
6. **Result**: Image appears on right side

---

## 📝 Step 8: Optimize for Pixel Art

Create a simple workflow:

**In ComfyUI UI**:
1. Start with blank canvas
2. Add nodes (right-click → Add Node):
   - `Load Checkpoint` → select your model
   - `CLIP Text Encode (Positive)`
   - `CLIP Text Encode (Negative)`
   - `KSampler`
   - `VAE Decode`
   - `Save Image`

3. Connect them together (drag outputs to inputs)
4. Set sampler settings:
   - Steps: 20-30
   - CFG: 7-10
   - Sampler: `euler` or `dpmpp_2m`

---

## 🚄 Step 9: Batch Generation Setup

For generating multiple assets efficiently:

```bash
# Create a batch script (optional)
# File: ~/ComfyUI/batch_generate.py

# Or use ComfyUI Manager's queue system:
# 1. Load workflow
# 2. Change prompt
# 3. Queue multiple times
# 4. Let it run through all
```

---

## ⚡ Performance Tips

### GPU Usage (if you have GPU)
```bash
# For NVIDIA (most common)
cd ~/ComfyUI
python main.py --use-cuda

# For AMD
python main.py --use-rocm

# For Intel GPU
python main.py --use-ipex
```

### CPU-Only (slower but works)
```bash
# Already default, will use CPU if no GPU detected
python main.py
```

### Memory Issues?
```bash
# Reduce VRAM usage
python main.py --normalvram  # Medium usage
python main.py --lowvram      # Low VRAM mode
python main.py --cpu           # Force CPU (slow)
```

---

## 📁 Folder Structure

After setup, you'll have:

```
~/ComfyUI/
├── main.py
├── web/
├── models/
│   ├── checkpoints/          # Your models live here
│   ├── vae/
│   └── loras/
├── custom_nodes/
├── output/                    # Generated images save here
├── venv/                      # Python environment
└── requirements.txt
```

---

## 🎯 Using ComfyUI for Your Assets

### Workflow for Pixel Art:

1. **Start ComfyUI**:
   ```bash
   cd ~/ComfyUI
   source venv/bin/activate
   python main.py
   ```

2. **Open browser**: http://127.0.0.1:8188

3. **Enter prompts** from your `AI_GENERATION_PROMPTS.md` file

4. **Key settings for pixel art**:
   - Image size: 64×64, 96×96, 256×256 (match your asset sizes)
   - Sampler: `euler` or `dpmpp_2m_karras`
   - Steps: 20-30
   - CFG Scale: 7-10
   - Negative prompt: `"anti-aliasing, blurry, gradient, smooth shading"`

5. **Generate**: Click "Queue Prompt"

6. **Output**: Images saved to `~/ComfyUI/output/`

7. **Copy to project**:
   ```bash
   cp ~/ComfyUI/output/*.png ~/Claude_GameDev/assets/[category]/
   ```

---

## 🔧 Troubleshooting

### Issue: "Model not found"
**Solution**:
```bash
# Verify models directory
ls ~/ComfyUI/models/checkpoints/
# Should show your .safetensors file
```

### Issue: Out of Memory
**Solution**:
```bash
# Use low VRAM mode
python main.py --lowvram
```

### Issue: Very slow generation
**Solution**:
- Reduce steps (20 instead of 30)
- Use smaller image size
- Use CPU + GPU offloading
- Check if GPU is being used: `nvidia-smi` (NVIDIA only)

### Issue: First generation takes forever
**Solution**: Normal - downloading VAE and other components. Wait 5-10 minutes.

### Issue: Can't access http://127.0.0.1:8188
**Solution**:
```bash
# Make sure server is running and shows:
# "To see the GUI go to: http://127.0.0.1:8188"

# If stuck, restart:
# Ctrl+C to stop
# Then: python main.py
```

---

## 🎨 Pixel Art Prompt Template (for ComfyUI)

Use this prompt format in ComfyUI for best pixel art results:

```
Positive Prompt:
pixel art [item description], [color], [size]×[size] pixels,
64×64 grid, isometric 3/4 view, flat colors, no anti-aliasing,
cute aesthetic, Stardew Valley style, transparent background,
2px outline weight

Negative Prompt:
anti-aliasing, blurry, gradient, smooth shading, 3D, realistic,
photorealistic, complex background, clutter, high detail, smooth edges
```

---

## 📊 Example: Generate a T-Shirt

1. **Open ComfyUI**: http://127.0.0.1:8188

2. **Set image size**: 64×64

3. **Positive prompt**:
   ```
   pixel art tshirt, red color, 64x64 pixels, flat colors, no anti-aliasing,
   cute aesthetic, Stardew Valley style, transparent background
   ```

4. **Negative prompt**:
   ```
   anti-aliasing, blurry, gradient, smooth shading, 3D, realistic
   ```

5. **Settings**:
   - Sampler: euler
   - Steps: 25
   - CFG: 8
   - Seed: random

6. **Queue Prompt**

7. **Result**: Image appears, save it

8. **Copy to assets**:
   ```bash
   cp ~/ComfyUI/output/[filename] ~/Claude_GameDev/assets/clothing/tshirt_red.png
   ```

---

## 🚀 Quick Start Summary

```bash
# 1. Clone
git clone https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI

# 2. Setup environment
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# 3. Download model
mkdir -p models/checkpoints
cd models/checkpoints
wget https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.safetensors
cd ../..

# 4. Start
python main.py

# 5. Open browser
# Go to: http://127.0.0.1:8188
```

**Total setup time**: 15-30 minutes (mostly downloading models)

---

## 📚 Next Steps

1. ✅ Complete setup above
2. Test with one asset (e.g., red t-shirt)
3. Use prompts from `AI_GENERATION_PROMPTS.md`
4. Batch generate Phase 1 assets
5. Touch up in Aseprite/Krita as needed

---

## 🆘 Help Resources

- **ComfyUI GitHub**: https://github.com/comfyanonymous/ComfyUI
- **Wiki**: https://github.com/comfyanonymous/ComfyUI/wiki
- **Discord**: https://discord.gg/comfyui
- **Troubleshooting**: Check the GitHub Issues

---

**Ready?** Start with Step 1 and let me know if you hit any issues!
