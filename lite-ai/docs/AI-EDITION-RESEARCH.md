# Ratan OS Lite AI Edition — Verified Design Notes

## Model choice

The selected model is **Qwen/Qwen3-4B-GGUF:Q4_K_M**. The official Qwen GGUF card documents this quantization, Apache-2.0 licensing, llama.cpp compatibility, local inference support and a 2.5 GB model size. Qwen3 supports both thinking and non-thinking modes; Ratan OS Lite will default to non-thinking mode for faster local responses and expose an explicit `/think` option to the user.

## Runtime choice

The AI Edition will use `llama.cpp` CPU inference with a conservative context size. The official Qwen model card demonstrates llama.cpp command-line and local OpenAI-compatible server usage. The runtime will not start network activity or expose any service by default.

## Release-size constraint

Ratan OS Lite v1.1.0 is 730,857,472 bytes. Adding the 2.5 GB Q4_K_M model is expected to produce an ISO around 3.2 GB. GitHub Releases limits each individual release asset to less than 2 GiB, so the final AI ISO must be delivered as verified split parts for reconstruction after download.

## Sources

1. https://huggingface.co/Qwen/Qwen3-4B-GGUF
2. https://github.com/QwenLM/Qwen3
3. https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases
