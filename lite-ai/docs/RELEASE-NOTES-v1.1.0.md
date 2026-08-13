# Ratan OS Lite v1.1.0

Ratan OS Lite v1.1.0 is the focused, compact edition of Ratan OS. It is a Debian Trixie XFCE live environment with curated Tool Collections for authorized assessment, analysis, host auditing and hardening.

## What changed

This edition removes non-essential office software, media applications, server services and large development stacks. It adds the **Ratan OS Lite Tool Collections** desktop shortcut and `ratan-collections` terminal command so users can find included tools by task area without starting any network activity.

## Tool Collections

| Category | Included tools |
|---|---|
| Network & Discovery | Nmap, arp-scan, traceroute |
| Web Assessment | SQLMap, FFUF, Gobuster |
| Traffic Analysis | tcpdump, TShark, MTR |
| TLS & Service Review | SSLScan, WhatWeb, Nmap |
| Host Audit | Lynis, Debsecan, UFW |
| Triage | rkhunter, chkrootkit, lsof |

## Verified artifact

| Item | Value |
|---|---|
| ISO file | `ratan-os-lite-amd64.iso` |
| Size | 730,857,472 bytes (approximately 697 MiB) |
| SHA-256 | `687c763c7c139d6a9a8d6c86d24a241763eb9dcb1e75efc91ac16400116551f7` |
| Architecture | x86_64 / amd64 |
| Boot | BIOS El Torito + hybrid DOS/MBR |
| QEMU | BIOS smoke-tested with 2 GiB RAM and 2 vCPUs |

Validate the ISO against the `SHA256SUMS` asset before booting.

## Security boundary

Use only with explicit written authorization, an agreed scope, request-rate limits and stop conditions. This release excludes DDoS/load generation, credential attacks, phishing, malware, stealth/persistence, data exfiltration and destructive payloads.

See `RATAN-OS-LITE-GUIDE.md` for Tool Collections, QEMU instructions and operating boundaries.
