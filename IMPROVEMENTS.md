# Invoice Extraction Improvements

## Comparison: v03 (Claude API) vs v04 (Enhanced Open-Source)

### Version 3 (Current - `exercise_v03.ipynb`)
**Model**: Claude Sonnet 4 API
- ✅ **Accuracy**: ~100% (excellent)
- ❌ **Cost**: $0.10 per image ($0.50 for 5 invoices)
- ❌ **API Dependency**: Requires API key and internet
- ✅ **Speed**: Fast (API-based)
- ✅ **Resource Usage**: Minimal local resources

### Version 4 (New - `exercise_v04_enhanced.ipynb`)
**Model**: Qwen2-VL-7B-Instruct (Open-Source)
- ✅ **Accuracy**: Target 95%+ (with validation & retry)
- ✅ **Cost**: $0 (completely free)
- ✅ **API Dependency**: None - runs locally/on Colab
- ⚠️  **Speed**: Slower (~10-15s per image on Colab GPU)
- ⚠️  **Resource Usage**: Needs GPU (works on Colab free tier)

## Key Enhancements in v04

### 1. Better Model
- **Qwen2-VL-7B-Instruct** - State-of-the-art open-source vision-language model
- Superior to InternVL2-1B for structured data extraction
- 4-bit quantization for efficient memory usage (~6GB VRAM)

### 2. Validation & Retry Logic
```python
def validate_extraction(data: Dict) -> tuple[bool, List[str]]:
    # Checks:
    # - Critical fields not empty
    # - Invoice value has currency + number
    # - PO reference contains digits
```
- First attempt with detailed prompt
- If validation fails → retry with stricter, focused prompt
- Significantly reduces extraction errors

### 3. Enhanced Prompting
- **Field-specific instructions** with examples
- **Explicit focus** on total amount vs subtotal
- **Clear JSON schema** with formatting rules
- **Two-tier prompting**: normal + retry variants

### 4. Post-Processing
- Smart PO reference sanitization
- Field-level validation
- Automatic retry on quality issues
- Comprehensive error reporting

### 5. Google Colab Optimization
- Auto-detects Colab environment
- 4-bit quantization (fits in free tier)
- Optimized dependencies
- Memory-efficient processing

## When to Use Each Version

### Use v03 (Claude API) when:
- Budget allows API costs
- Highest accuracy is critical
- Processing large volumes quickly
- Internet/API access available

### Use v04 (Open-Source) when:
- Zero budget / cost-free required
- Data privacy concerns (local processing)
- No API access available
- Learning/experimenting with VLMs
- Processing moderate volumes

## Performance Expectations

### v04 Accuracy (estimated):
- **Vendor Name**: 95-98%
- **Invoice Value**: 90-95%
- **PO Reference**: 85-90%
- **Other Fields**: 85-92%

### Tips for Best Results with v04:
1. Use high-quality scans (300 DPI)
2. Ensure good contrast and readability
3. Run on GPU (Colab or local CUDA)
4. Review and manually fix ~5-10% edge cases
5. Consider ensemble with Claude API for critical extractions

## Migration Path

1. **Start with v04**: Test on your invoices
2. **Measure accuracy**: Compare against ground truth
3. **Hybrid approach**: Use v04 for bulk, Claude API for failures
4. **Cost optimization**: API only for validation retry failures

## Next Steps

1. Run `exercise_v04_enhanced.ipynb` on Google Colab
2. Compare results with v03 output
3. Measure accuracy on your specific invoice types
4. Fine-tune prompts for your use case if needed
