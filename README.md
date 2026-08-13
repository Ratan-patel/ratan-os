# Ratan OS

**Ratan OS** is a compact Debian Trixie XFCE live environment for authorized security learning, defensive analysis, controlled assessment labs and incident-response preparation. The project is designed to remain transparent: releases include checksums, reproducible build configuration, QEMU guidance and a clear acceptable-use boundary.

## Current releases

| Edition | Release | What it includes | Download |
|---|---|---|---|
| **Lite AI Edition v1.2.0** | Current | Offline Qwen3-4B Q4_K_M, CPU-only llama.cpp, local `ratan-ai` launcher, QEMU BIOS support and curated Tool Collections | [Release and verification center](https://ratan-patel.github.io/ratan-os-release.html) |
| **Lite v1.1.0** | Compact archive | Focused authorized-security Tool Collections without the embedded language model | [GitHub Release v1.1.0](https://github.com/Ratan-patel/ratan-os/releases/tag/v1.1.0) |
| **Full v1.0.0** | Earlier edition | Original Ratan OS package and build history | [GitHub Release v1.0.0](https://github.com/Ratan-patel/ratan-os/releases/tag/v1.0.0) |

The current AI Edition ISO is delivered as two GitHub Release assets because of the per-asset size limit. Download both parts, the `SHA256SUMS` file and the reassembly guide from the [Ratan OS Release & Trust Center](https://ratan-patel.github.io/ratan-os-release.html). The final ISO must be reconstructed and checksum-verified before booting.

## Lite AI Edition highlights

The AI Edition combines the small focused Lite tool collection with a bundled offline language model. Qwen3-4B runs locally through llama.cpp and does not require a cloud account, API key or Internet connection at runtime. The assistant is intended for Linux help, permitted learning, report drafting and defensive analysis; it is not a substitute for written authorization or professional review.

The curated Tool Collections include Nmap, arp-scan, traceroute, SQLMap, FFUF, Gobuster, tcpdump, TShark, MTR, SSLScan, WhatWeb, Lynis, Debsecan, UFW, rkhunter, chkrootkit and lsof. Tools that can generate significant traffic or modify targets must be used only within an approved scope, controlled rate limits and a defined testing window.

## QEMU BIOS

The tested legacy-BIOS command for the AI Edition is:

```bash
qemu-system-x86_64 -M pc -accel kvm -m 8192 -smp 4 \\
  -cdrom ratan-os-lite-ai-amd64.iso -boot order=d \\
  -nic user,model=e1000 -display gtk
```

Use `-accel tcg` when KVM is unavailable. The current image is BIOS/hybrid compatible and does not include a UEFI El Torito entry. The release guide contains the complete split-file reconstruction, checksum and QEMU workflow.

## Build from source

The reproducible source configuration for the AI Edition is in [`lite-ai/`](lite-ai/). It deliberately excludes generated ISO files, the multi-gigabyte Qwen3 model and compiled runtime payloads from Git history. The fetcher downloads pinned external assets and verifies their checksums during the build process.

```bash
git clone https://github.com/Ratan-patel/ratan-os.git
cd ratan-os/lite-ai
./build.sh
```

Review the [AI Edition guide](lite-ai/docs/RATAN-OS-LITE-AI-GUIDE.md) and the [research notes](lite-ai/docs/AI-EDITION-RESEARCH.md) before building. A build host needs sufficient free storage for the model, live-build workspace and generated ISO.

## Scope and safety

Use Ratan OS only on systems and networks covered by explicit written authorization, an agreed asset list, rate limits, a testing window, an evidence policy and stop conditions. Never use it against third-party infrastructure without permission. The project excludes and does not permit DDoS, phishing, credential theft, password attacks, malware, stealth or persistence, data exfiltration, destructive payloads or unauthorized access.

SQLMap, Gobuster, FFUF and similar tools are intended only for approved targets and controlled request rates. Do not place production credentials, regulated data, customer information or private keys into the local AI assistant.

## Project links

- [Ratan OS Release & Trust Center](https://ratan-patel.github.io/ratan-os-release.html)
- [Ratan OS source repository](https://github.com/Ratan-patel/ratan-os)
- [Ratan OS Lite AI source configuration](https://github.com/Ratan-patel/ratan-os/tree/main/lite-ai)
- [Ratan Patel website](https://ratan-patel.github.io/)
- [Terms, privacy, refunds and acceptable use](https://ratan-patel.github.io/acceptable-use.html)

## License and attribution

Ratan OS build configuration and documentation are published in this repository. Third-party components retain their original licenses. The bundled Qwen3 model is distributed under its applicable Apache-2.0 terms; review the release documentation and upstream notices before redistribution.
