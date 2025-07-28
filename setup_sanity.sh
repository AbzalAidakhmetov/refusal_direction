#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------------------------
# 1 · Miniconda (skip if already installed)
# ------------------------------------------------------------------------------
if [[ ! -d "$HOME/miniconda3" ]]; then
  echo "👉 Installing Miniconda…"
  wget -qO /tmp/miniconda.sh \
       https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
  bash /tmp/miniconda.sh -b -p "$HOME/miniconda3"
  rm /tmp/miniconda.sh
fi

# Make the `conda` command available in this shell
source "$HOME/miniconda3/etc/profile.d/conda.sh"

# ------------------------------------------------------------------------------
# 2 · Environment
# ------------------------------------------------------------------------------
if ! conda info --envs | grep -q '^refusal-env'; then
  conda create -y -n refusal-env python=3.11
fi
conda activate refusal-env       # now the env’s own python/pip are on PATH

# ------------------------------------------------------------------------------
# 3 · Packages
# ------------------------------------------------------------------------------
python -m pip install --upgrade pip
python -m pip install -r requirements_sanity.txt

# ------------------------------------------------------------------------------
# 4 · (Opt) register Jupyter kernel
# ------------------------------------------------------------------------------
python -m ipykernel install --user \
        --name refusal-env --display-name "Python (refusal-env)"

echo -e "\n✅  refusal-env ready.  Launch with:  conda activate refusal-env"
