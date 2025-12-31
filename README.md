# Garbled Circuits demo

[View the notebook (static HTML)](https://sjors.github.io/garbled-circuits/garble.html)

This repo walks through the classical Yao garbled AND example from Section 1.1 of Sophia Yakoubov’s “A Gentle Introduction to Yao’s Garbled Circuits” ([PDF](https://cs-people.bu.edu/sophia/GC.pdf)). The notebook shows how Ginny garbles a single AND gate, how labels are delivered (first with a toy OT, then with a simple secp256k1 + SHA-256 OT), how Evan evaluates once, and how the output label is returned and decoded. It is educational only and not a production-ready implementation.

## Prerequisites
- Rust toolchain via [rustup](https://rustup.rs/) (provides `cargo` and `rustc`)
- Jupyter (e.g., via `pip install jupyter` or existing VS Code Jupyter support)
- `evcxr_jupyter` for running Rust in notebooks

## Installation
1) Install the Rust notebook kernel:
   - `cargo install evcxr_jupyter`
   - `evcxr_jupyter --install`
2) Open [garble.ipynb](garble.ipynb) in VS Code or Jupyter.
3) Run the cells top-to-bottom. The notebook declares its own dependencies (`rand`, `sha2`, `base64`, `k256`) via `:dep`, so no extra Cargo setup is needed.

## Files
- [garble.ipynb](garble.ipynb): step-by-step Ginny/Evan garbled AND walkthrough, including a simple semi-honest 1-of-2 OT and notes on an optional OR-proof to stop `(pk, pk)` cheating.
- [A Gentle Introduction to Yao’s Garbled Circuits (PDF)](https://cs-people.bu.edu/sophia/GC.pdf): reference paper

## References
- Sophia Yakoubov, "A Gentle Introduction to Yao’s Garbled Circuits" ([PDF](https://cs-people.bu.edu/sophia/GC.pdf))
