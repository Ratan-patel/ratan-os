# Ratan OS Lite v1.1.0

Ratan OS Lite is a compact Debian Trixie XFCE live image for authorized security assessment, traffic analysis, host auditing, incident-response triage and hardening. It deliberately removes non-essential office, media, server and large developer packages in favor of focused Tool Collections.

## Artifact verification

The ISO file is `ratan-os-lite-amd64.iso`.

```bash
sha256sum ratan-os-lite-amd64.iso
```

Compare the result with the `SHA256SUMS` release asset before booting.

## Tool Collections

Run `ratan-collections` in the live terminal or open the **Ratan OS Lite Tool Collections** desktop shortcut. Collections include Network & Discovery, Web Assessment, Traffic Analysis, TLS & Service Review, Host Audit and Triage.

| Collection | Tools |
|---|---|
| Network & Discovery | Nmap, arp-scan, traceroute |
| Web Assessment | SQLMap, FFUF, Gobuster |
| Traffic Analysis | tcpdump, TShark, MTR |
| TLS & Service Review | SSLScan, WhatWeb, Nmap |
| Host Audit | Lynis, Debsecan, UFW |
| Triage | rkhunter, chkrootkit, lsof |

## QEMU BIOS / legacy mode

The same ISO runs in QEMU; no separate virtual-machine image is required.

```bash
qemu-system-x86_64 \
  -M pc \
  -accel kvm \
  -m 2048 \
  -smp 2 \
  -cdrom ratan-os-lite-amd64.iso \
  -boot order=d \
  -nic user,model=e1000 \
  -display gtk
```

Run `./run-qemu-bios.sh` from the source directory for the same setup. If KVM is unavailable, use `QEMU_ACCEL=tcg ./run-qemu-bios.sh`.

## Use boundary

Use only under explicit written authorization, with agreed target scope, request-rate limits, a testing window and stop conditions. This release excludes DDoS/load generation, credential attacks, phishing, malware, stealth/persistence, data exfiltration and destructive payloads.

> The ISO includes a bootable DOS/MBR system area and BIOS El Torito `isolinux` entry. It was smoke-tested in QEMU BIOS mode with 2 GiB RAM and two virtual CPUs. This build does not include a UEFI El Torito boot entry.
