#!/bin/bash

# Exit on error
set -e

echo "Starting pipeline execution..."

# Install uv and create virtual environment
curl -LsSf https://astral.sh/uv/install.sh | sh
uv venv .venv
source .venv/bin/activate

# 1. Install requirements
echo "Installing requirements..."
uv pip install -r requirements.txt

# 2. Run tests
echo "Running tests..."
python -m pytest tests/

# 3. Run fineweb.py
echo "Running fineweb.py..."
python fineweb.py

# 4. Run training script with torchrun
echo "Starting distributed training..."
torchrun --standalone --nproc_per_node=auto train.py

echo "Pipeline completed successfully!"