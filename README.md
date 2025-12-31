# Garbled Circuits demo

This repo walks through the classical Yao garbled AND example from Section 1.1 of Sophia Yakoubov’s “A Gentle Introduction to Yao’s Garbled Circuits” ([PDF](https://cs-people.bu.edu/sophia/GC.pdf)). The notebook shows how Ginny garbles a single AND gate, how labels are delivered with a toy OT, how Evan evaluates once, and how the output label is returned and decoded. It is educational only and not a secure implementation.

## Prerequisites
- Rust toolchain via [rustup](https://rustup.rs/) (provides `cargo` and `rustc`)
- Jupyter (e.g., via `pip install jupyter` or existing VS Code Jupyter support)
- `evcxr_jupyter` for running Rust in notebooks

## Installation
1) Install the Rust notebook kernel:
   - `cargo install evcxr_jupyter`
   - `evcxr_jupyter --install`
2) Open [garble.ipynb](garble.ipynb) in VS Code or Jupyter.
3) Run the cells top-to-bottom. The notebook declares its own dependencies (`rand`, `sha2`, `base64`) via `:dep`, so no extra Cargo setup is needed.

## Files
- [garble.ipynb](garble.ipynb): step-by-step Ginny/Evan garbled AND walkthrough
- [A Gentle Introduction to Yao’s Garbled Circuits (PDF)](https://cs-people.bu.edu/sophia/GC.pdf): reference paper

## References
- Sophia Yakoubov, "A Gentle Introduction to Yao’s Garbled Circuits" ([PDF](https://cs-people.bu.edu/sophia/GC.pdf))
