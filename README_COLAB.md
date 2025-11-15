# 🚀 Running Invoice Extraction on Google Colab

## Quick Start (Easiest Method)

### Step 1: Open in Colab

Click this button to open the quick-start notebook directly in Google Colab:

```
https://colab.research.google.com/github/marvin-schumann/orbit_challenge/blob/claude/capabilities-overview-01BzAZxMUjPBveeHos3gVvok/colab_quickstart.ipynb
```

Or manually:
1. Go to [Google Colab](https://colab.research.google.com)
2. Click `File` → `Open notebook`
3. Click `GitHub` tab
4. Paste: `marvin-schumann/orbit_challenge`
5. Select branch: `claude/capabilities-overview-01BzAZxMUjPBveeHos3gVvok`
6. Click on: `colab_quickstart.ipynb`

### Step 2: Enable GPU

**IMPORTANT**: You need GPU for reasonable performance!

1. Click `Runtime` → `Change runtime type`
2. Hardware accelerator: Select **GPU** (T4 is fine)
3. Click **Save**

### Step 3: Run All Cells

1. Click `Runtime` → `Run all`
2. Wait ~3-5 minutes (first run downloads the model)
3. Review results!

That's it! The notebook handles everything automatically.

---

## What You're Testing

You're comparing two approaches:

### v03 (Current - Claude API)
- ✅ ~100% accuracy
- ❌ Costs $0.10 per image
- ✅ Fast
- ❌ Requires API key

### v04 (New - Open Source)
- ⚠️ ~90-95% accuracy (needs testing!)
- ✅ $0 cost
- ⚠️ Slower (~10-15s per image)
- ✅ No API key needed

**Your job**: Run v04 and tell me:
1. What's the actual accuracy?
2. Which fields have errors?
3. Which invoices failed?

Then I can improve it!

---

## Expected Output

You should see:

```
✅ Loaded 5 page(s) from 5 invoice(s)

📄 INV-2020-08-001247 (page 1):
  🤖 Extracting with Qwen2-VL...
  ✅ Extraction validated!
  📊 Extracted 7/7 fields

[... more invoices ...]

✅ EXTRACTION COMPLETE

📋 Extracted 5 invoices:

vendor_name          vendor_address              invoice_value  po_reference
Vendor40 Corporation 5678 Vendor Street...      €3,960.00      00000586652
[... more rows ...]
```

---

## What Can Go Wrong?

### 1. "Out of Memory"
**Solution**:
- Runtime → Restart runtime
- Verify GPU is enabled
- Try again

### 2. "Directory not found"
**Solution**: The quickstart notebook auto-fixes paths, but if needed:
```python
INVOICE_DIR = Path("/content/orbit_challenge/Invoices")
```

### 3. "No GPU detected"
**Solution**:
- Runtime → Change runtime type → GPU
- Restart runtime
- Run again

### 4. Low Accuracy
**Solution**:
- Share the results with me
- Tell me which fields are wrong
- I'll improve the prompts!

---

## After Running - What to Check

### 1. Compare with v03 Results

You have v03 output from `exercise_v03.ipynb`. Compare:

| Invoice | Field | v03 (Claude) | v04 (Qwen) | Match? |
|---------|-------|--------------|------------|--------|
| INV-2020-001 | po_reference | 00000048334 | ??? | ??? |

### 2. Calculate Accuracy

```python
# In a new cell, compare with your v03 results:
v03_results = {
    'INV-2020-08-001247': '00000586652',
    'INV-2020-001': '00000048334',
    # ... add others
}

correct = 0
total = 0
for idx, row in df.iterrows():
    inv_id = row['invoice_id']
    if inv_id in v03_results:
        total += 1
        if row['po_reference'] == v03_results[inv_id]:
            correct += 1
        else:
            print(f"❌ {inv_id}: {row['po_reference']} vs {v03_results[inv_id]}")

accuracy = (correct / total) * 100
print(f"\n✅ PO Reference Accuracy: {accuracy:.1f}%")
```

### 3. Share Results

Tell me:
- Overall accuracy percentage
- Which specific fields had errors
- Any patterns you notice

---

## Performance Metrics

### First Run (Downloads Model)
- Setup: ~2-3 minutes
- Model download: ~3-4 GB
- Per invoice: ~10-15 seconds
- **Total for 5 invoices: ~5-8 minutes**

### Subsequent Runs (Model Cached)
- Setup: ~30 seconds
- Per invoice: ~10-15 seconds
- **Total for 5 invoices: ~2-3 minutes**

### Memory Usage
- Model: ~6 GB VRAM (4-bit quantization)
- Colab Free Tier: ~12-16 GB (plenty!)

---

## Alternative: Manual Upload

If you don't want to clone the repository:

1. Open `exercise_v04_enhanced.ipynb` directly in Colab
2. Upload your invoice files to `/content/Invoices/`
3. Upload `push.ipynb` to `/content/`
4. Update path: `INVOICE_DIR = Path("/content/Invoices")`
5. Run all cells

---

## Need Help?

Share with me:
1. **Error messages** (copy-paste the full error)
2. **Accuracy results** (which fields are wrong)
3. **Screenshots** (if helpful)

I can then:
- Debug errors
- Improve prompts for better accuracy
- Optimize the extraction logic
- Create a hybrid version (open-source + Claude fallback)

---

## Cost Comparison

### Your 5 invoices:

| Method | Cost | Time | Accuracy |
|--------|------|------|----------|
| v03 (Claude) | $0.50 | 2 min | ~100% |
| v04 (Qwen) | $0.00 | 5 min | ~95%? |

### For 100 invoices:

| Method | Cost | Time | Accuracy |
|--------|------|------|----------|
| v03 (Claude) | $10.00 | 10 min | ~100% |
| v04 (Qwen) | $0.00 | 30 min | ~95%? |

### Hybrid approach (best of both):

Use v04 first, Claude API only for failures:
- Cost: ~$1-2 (only paying for retries)
- Accuracy: ~100% (Claude fixes the 5% errors)
- Time: ~30 min

---

## Next Steps

1. ✅ Run `colab_quickstart.ipynb`
2. 📊 Review accuracy vs v03
3. 💬 Share results with me
4. 🔧 I'll optimize based on your feedback
5. 🚀 Deploy the best solution!

Good luck! Let me know how it goes! 🎉
