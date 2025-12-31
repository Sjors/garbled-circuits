#!/usr/bin/env bash
set -euo pipefail

# Resolve repo root using git so symlinked hooks still work.
repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

nb="garble.ipynb"
out="garble.html"

if ! command -v jupyter >/dev/null 2>&1; then
  echo "[pre-commit] jupyter not found; install Jupyter + nbconvert to render HTML." >&2
  exit 1
fi

# Execute notebook in a fresh kernel so execution counts and outputs are deterministic.
jupyter nbconvert \
  --to notebook \
  --execute \
  --inplace \
  --output "$nb" \
  --ExecutePreprocessor.timeout=600 \
  "$nb"

# Regenerate static HTML from the executed notebook; nbconvert comes with Jupyter.
jupyter nbconvert --to html "$nb" --output "$(basename "$out")" --output-dir "$repo_root"

# Stage the generated HTML so the commit always has the fresh render.
git add "$out"
