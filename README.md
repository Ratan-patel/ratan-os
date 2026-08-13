# Ratan OS

Ratan OS is a compact Debian Trixie XFCE live image for authorized security assessment, packet analysis, defensive hardening review and incident-response preparation.

## Download

Download the current ISO from the [Ratan OS v1.0.0 GitHub Release](../../releases/tag/v1.0.0). Verify it with the published `SHA256SUMS` file.

## QEMU

The tested BIOS/legacy command is:

```bash
qemu-system-x86_64 -M pc -accel kvm -m 2048 -smp 2 -cdrom ratan-os-amd64.iso -boot order=d -nic user,model=e1000 -display gtk
```

Use `-accel tcg` when KVM is unavailable. The current image contains a BIOS El Torito `isolinux` entry and does not include a UEFI El Torito entry.

## Scope and safety

Use this image only with explicit written authorization and an agreed target scope, rate limit, testing window, evidence policy and stop conditions. The image includes controlled assessment tools such as Nmap, SQLMap, Gobuster, FFUF, WhatWeb, SSLScan, Wireshark/TShark and defensive utilities.

It intentionally excludes DDoS/load-generation tooling, phishing and social-engineering tooling, credential theft or password-attack tooling, stealth/persistence tooling and destructive payloads. SQLMap, Gobuster and FFUF are for approved targets and controlled request rates only.

See [`docs/RATAN-OS-GUIDE.md`](docs/RATAN-OS-GUIDE.md) for the full guide and [`build.sh`](build.sh) for the reproducible build wrapper.
