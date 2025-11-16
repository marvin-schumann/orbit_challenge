# Running exercise_v04_enhanced.ipynb on Google Colab

## Option 1: Clone Repository (Recommended)

This approach gets your entire repository including invoices and push.ipynb.

### Step-by-Step:

1. **Open Google Colab**: Go to [colab.research.google.com](https://colab.research.google.com)

2. **Create a new notebook** and run these cells:

```python
# Cell 1: Clone your repository
!git clone https://github.com/marvin-schumann/orbit_challenge.git
%cd orbit_challenge
!ls -la  # Verify files are there
```

```python
# Cell 2: Checkout your branch
!git checkout claude/capabilities-overview-01BzAZxMUjPBveeHos3gVvok
!ls -la  # Verify you're on the right branch
```

```python
# Cell 3: Run your notebook
%run exercise_v04_enhanced.ipynb
```

3. **Check GPU is enabled**:
   - Click `Runtime` → `Change runtime type`
   - Hardware accelerator: **GPU** (T4 is fine)
   - Save

4. **Run the cells** in order

### Updating the Invoice Path

The notebook auto-detects Colab, but you need to update the path to:

```python
INVOICE_DIR = Path("/content/orbit_challenge/Invoices")
```

---

## Option 2: Upload Files Manually

If you prefer to upload files instead of cloning:

### Step 1: Open the Notebook in Colab

1. Go to your GitHub repository
2. Navigate to `exercise_v04_enhanced.ipynb`
3. Click **"Open in Colab"** badge (or copy the URL)
4. Or use: `https://colab.research.google.com/github/marvin-schumann/orbit_challenge/blob/main/exercise_v04_enhanced.ipynb`

### Step 2: Upload Required Files

In Colab, run this cell first:

```python
# Create directory structure
!mkdir -p /content/Invoices
print("✅ Directory created")
```

Then:

1. **Upload Invoices**:
   - Click the folder icon 📁 on the left sidebar
   - Navigate to `/content/Invoices`
   - Click upload button and select all your invoice PDFs/images

2. **Upload push.ipynb**:
   - Upload `push.ipynb` to `/content/`

### Step 3: Update Paths in the Notebook

Before running, modify this section:

```python
# Update these paths
INVOICE_DIR = Path("/content/Invoices")  # Already set for Colab

# Later when you run push.ipynb:
%run /content/push.ipynb
```

---

## Option 3: Mount Google Drive (Best for Repeated Use)

If you'll run this multiple times, store files in Google Drive:

```python
# Cell 1: Mount Google Drive
from google.colab import drive
drive.mount('/content/drive')
```

```python
# Cell 2: Copy files from GitHub to Drive (one-time setup)
!git clone https://github.com/marvin-schumann/orbit_challenge.git /content/drive/MyDrive/orbit_challenge
```

```python
# Cell 3: Navigate and run
%cd /content/drive/MyDrive/orbit_challenge
!git checkout claude/capabilities-overview-01BzAZxMUjPBveeHos3gVvok
%run exercise_v04_enhanced.ipynb
```

**Benefits**:
- Files persist across sessions
- No need to re-upload invoices each time
- Can edit and save changes

---

## Troubleshooting

### Issue: "Directory not found"
```python
# Check where you are
!pwd
!ls -la

# Update the path in the notebook
INVOICE_DIR = Path("/content/orbit_challenge/Invoices")  # or wherever your files are
```

### Issue: "Out of memory"
```python
# Restart runtime and ensure GPU is enabled
# Runtime → Restart runtime
# Runtime → Change runtime type → GPU
```

### Issue: "Module not found"
```python
# The notebook auto-installs packages, but if needed:
!pip install qwen-vl-utils transformers accelerate bitsandbytes
```

### Issue: Can't find push.ipynb
```python
# Check if it exists
!ls -la *.ipynb

# If you're in a subdirectory, navigate to root
%cd /content/orbit_challenge

# Then run
%run push.ipynb
```

---

## Recommended Workflow

**First Time Setup** (5 minutes):
1. Open new Colab notebook
2. Enable GPU runtime
3. Clone repository
4. Checkout branch
5. Run exercise_v04_enhanced.ipynb

**Subsequent Runs** (2 minutes):
1. Open same Colab notebook
2. Run the clone/checkout cells again (Colab resets each session)
3. Run exercise_v04_enhanced.ipynb

---

## Quick Start Script

Copy this into a new Colab notebook for fastest setup:

```python
# ============================================================
# QUICK START: Run exercise_v04_enhanced.ipynb on Colab
# ============================================================

# Step 1: Setup
!git clone https://github.com/marvin-schumann/orbit_challenge.git
%cd orbit_challenge
!git checkout claude/capabilities-overview-01BzAZxMUjPBveeHos3gVvok

# Step 2: Verify files
!echo "📂 Checking invoices..."
!ls Invoices/ | head -5
!echo "\n📂 Checking notebooks..."
!ls *.ipynb

# Step 3: Run the enhanced extraction
print("\n🚀 Starting extraction...\n")
%run exercise_v04_enhanced.ipynb

# Step 4: Results will show automatically
# Step 5: Optionally push to Celonis
# %run push.ipynb
```

---

## Performance Tips

1. **Use GPU**: Essential for reasonable speed (~10-15s per image)
   - CPU mode will be very slow (~2-3 minutes per image)

2. **Monitor Memory**: Check GPU memory usage
   ```python
   !nvidia-smi
   ```

3. **Process in Batches**: If you have many invoices (>20), consider processing in batches

4. **Save Intermediate Results**: Export `df` to CSV for backup
   ```python
   df.to_csv('extracted_invoices.csv', index=False)
   ```

---

## Expected Runtime

- **Setup** (first time): ~2-3 minutes (downloading model)
- **Per Invoice**: ~10-15 seconds on GPU
- **5 Invoices Total**: ~2-5 minutes
- **Push to Celonis**: ~30 seconds

---

## Next Steps After Running

1. **Review the output** - check the detailed results table
2. **Validate accuracy** - compare with your v03 Claude API results
3. **Report issues** - if any invoices have errors, note which fields
4. **Share results** - I can help optimize based on what you find!
