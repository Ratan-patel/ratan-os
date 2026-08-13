# Ratan OS Lite AI Edition

## Purpose

Ratan OS Lite AI Edition is a Debian Trixie live image for **authorized security assessment, defensive analysis and local learning**. It contains the existing compact Ratan Tool Collections together with an offline **Qwen3-4B Q4_K_M** language model and a CPU-only `llama.cpp` runtime.

The model and runtime are packaged in the ISO. Local AI use therefore requires **no Internet connection, no cloud account and no API key**. Generated text is advisory only and must be reviewed before use.

> **Authorized use only.** Operate the included tools exclusively on systems and networks covered by explicit written authorization, agreed scope, rate limits and stop conditions. This edition does not include or permit DDoS, credential attacks, phishing, malware, stealth/persistence, data exfiltration or destructive activity.

## Hardware guidance

| Resource | Minimum practical level | Recommended level |
|---|---:|---:|
| Architecture | 64-bit x86 processor | 64-bit x86 processor |
| RAM for local AI | 6 GB | 8 GB or more |
| CPU | 2 cores | 4 or more cores |
| Storage for downloaded image | 4 GB free | 8 GB free |
| Network at runtime | Not required | Not required |

The embedded model is 2.5 GB and CPU inference speed varies significantly with the host processor. The model can take a short time to load after launch.

## Starting the assistant

From the XFCE desktop, double-click **Ratan AI Assistant (Offline)**. It opens the local assistant in the default browser at `http://127.0.0.1:8080` and keeps a terminal window open for the local server.

The terminal commands below are equivalent.

```bash
ratan-ai start
ratan-ai cli
ratan-ai help
```

The server binds only to `127.0.0.1`, so it is not reachable over the network. Type `/think` in a prompt for more deliberate reasoning or `/no_think` for a faster general answer.

## Local OpenAI-compatible endpoint

When `ratan-ai start` is running, compatible local clients can use the endpoint below without credentials.

```text
http://127.0.0.1:8080/v1
```

This endpoint is local to the live session. It does not imply Internet access or a hosted AI service.

## QEMU BIOS test

Use the bundled launcher from the extracted release directory.

```bash
chmod +x run-qemu-bios.sh
./run-qemu-bios.sh
```

The launcher defaults to 8 GB RAM and 4 virtual CPUs. Adjust them when necessary.

```bash
RATAN_AI_QEMU_RAM=6144 RATAN_AI_QEMU_CPUS=2 ./run-qemu-bios.sh
```

## Download reconstruction

The full AI ISO is larger than GitHub's per-file release-asset limit. The release supplies split parts. Download every part into the same directory, verify the release checksum file, then reconstruct the ISO as follows.

```bash
cat ratan-os-lite-ai-amd64.iso.part-* > ratan-os-lite-ai-amd64.iso
sha256sum -c SHA256SUMS
```

The reconstructed ISO can then be written to removable media or passed to QEMU.

## Components and licenses

| Component | Role | License | Source |
|---|---|---|---|
| Qwen3-4B GGUF Q4_K_M | Offline language model | Apache-2.0 | [Qwen model card](https://huggingface.co/Qwen/Qwen3-4B-GGUF) |
| llama.cpp | CPU inference server and CLI | MIT | [llama.cpp](https://github.com/ggml-org/llama.cpp) |
| Debian Trixie | Live operating-system base | Debian Free Software Guidelines / component licenses | [Debian](https://www.debian.org/) |

The full Qwen3 and llama.cpp license texts are included in the image under `/usr/share/doc/ratan-ai/`.

## Model provenance

The bundled model file is named `Qwen3-4B-Q4_K_M.gguf`. Its SHA-256 checksum is retained beside the model within the live image at:

```text
/usr/local/share/ratan-ai/models/Qwen3-4B-Q4_K_M.gguf.sha256
```

## References

[1] [Qwen/Qwen3-4B-GGUF model card](https://huggingface.co/Qwen/Qwen3-4B-GGUF)

[2] [Qwen3 repository and local llama.cpp guidance](https://github.com/QwenLM/Qwen3)

[3] [llama.cpp releases](https://github.com/ggml-org/llama.cpp/releases)

[4] [GitHub Releases limitations](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases)
