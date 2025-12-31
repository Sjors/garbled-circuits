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

# Use sccache to speed up Rust compilation if available.
if command -v sccache >/dev/null 2>&1; then
  export RUSTC_WRAPPER=sccache
fi

# Only re-execute if the notebook content changed.
if ! git diff --cached --name-only | grep -q "^${nb}$"; then
  echo "[pre-commit] $nb unchanged; skipping execution." >&2
  exit 0
fi

# Execute notebook in a fresh kernel so execution counts and outputs are deterministic.
jupyter nbconvert \
  --to notebook \
  --execute \
  --inplace \
  --output "$nb" \
  --ExecutePreprocessor.record_timing=False \
  --ExecutePreprocessor.timeout=600 \
  "$nb"

# Strip noisy execution metadata to avoid churn between runs.
python - <<'PY'
from pathlib import Path
import json

nb_path = Path("garble.ipynb")
nb = json.loads(nb_path.read_text())

for cell in nb.get("cells", []):
  meta_cell = cell.setdefault("metadata", {})
  meta_cell.pop("execution", None)
  if cell.get("cell_type") == "code":
    meta_cell.setdefault("language", "rust")
  else:
    meta_cell.pop("language", None)

meta = nb.setdefault("metadata", {})
meta.setdefault("kernelspec", {
  "display_name": "Rust",
  "language": "rust",
  "name": "rust",
})
meta.setdefault("language_info", {
  "codemirror_mode": "rust",
  "file_extension": ".rs",
  "mimetype": "text/rust",
  "name": "Rust",
  "pygment_lexer": "rust",
  "version": "",
})

nb_path.write_text(json.dumps(nb, ensure_ascii=False, indent=1))
PY

# Regenerate static HTML from the executed notebook; nbconvert comes with Jupyter.
jupyter nbconvert --to html "$nb" --output "$(basename "$out")" --output-dir "$repo_root"

# Stage the generated HTML so the commit always has the fresh render.
git add "$nb"
git add "$out"
