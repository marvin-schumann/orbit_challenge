#!/bin/bash

# Invoice Extraction Demo App - Quick Start Script

echo "🚀 Starting Invoice Extraction Demo App..."
echo ""

# Check if streamlit is installed
if ! command -v streamlit &> /dev/null
then
    echo "📦 Streamlit not found. Installing dependencies..."
    pip install -r requirements.txt
fi

# Check for poppler (PDF support)
if ! command -v pdftoppm &> /dev/null
then
    echo ""
    echo "⚠️  Warning: Poppler not found. PDF support may not work."
    echo "   Install with: brew install poppler (Mac) or apt-get install poppler-utils (Linux)"
    echo ""
fi

# Run the app
echo "✅ Launching app at http://localhost:8501"
echo "   Press Ctrl+C to stop"
echo ""

streamlit run app.py
