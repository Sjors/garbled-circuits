# Agent Guidelines

- If you edit code in a notebook cell, re-run that cell.
- Prefer explanations in Markdown cells over code comments when documenting notebooks.

Commit trailers to append on commits:
- Assisted-by: GitHub Copilot
- Assisted-by: OpenAI GPT-5.1-Codex-Max

Notebook hygiene (garble.ipynb):
- After a kernel restart, run cells top-to-bottom to recreate helpers and globals before the demos.
- Duplicate stdout is normal when rerunning cells without clearing outputs; no need to dedupe.
