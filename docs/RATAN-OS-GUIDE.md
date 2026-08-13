# Ratan OS — Authorized Security Live

## Overview

Ratan OS is a Debian Trixie XFCE live image for authorized security assessment, packet analysis, local hardening review, incident-response preparation and reporting. The image is designed to remain below the requested 2–3 GB limit; the current ISO is approximately 881 MB.

Use it only on systems and networks for which you have explicit written authorization. Define the target scope, testing window, rate limits, evidence-handling rules and stop conditions before using any assessment utility.

## Included assessment utilities

The image contains Nmap, SQLMap, Gobuster, FFUF, WhatWeb, SSLScan, arp-scan, tcpdump, Wireshark/TShark, traceroute, socat and related analysis utilities. SQLMap, Gobuster and FFUF are included for controlled, written-scope web assessment only. Do not use them for credential attacks, data extraction, destructive actions, uncontrolled high-rate traffic or targets outside the engagement.

The image intentionally excludes DDoS/load-generation tooling, phishing and social-engineering tooling, credential theft or password-attack tooling, stealth/persistence tooling and destructive payloads.

## Run in QEMU (BIOS)

The ISO contains a BIOS El Torito boot entry and was smoke-tested in QEMU with 2 GiB RAM and two virtual CPUs. On a Linux host, run:

```bash
qemu-system-x86_64 \
  -M pc \
  -accel kvm \
  -m 2048 \
  -smp 2 \
  -cdrom ratan-os-amd64.iso \
  -boot order=d \
  -nic user,model=e1000 \
  -display gtk
```

If KVM is unavailable, replace `-accel kvm` with `-accel tcg`. For a headless smoke test, use `-display none -monitor stdio` instead of `-display gtk`.

## Verify the download

After downloading the ISO, verify the SHA-256 digest:

```bash
sha256sum ratan-os-amd64.iso
```

Compare the result with `SHA256SUMS` supplied alongside the ISO. The build artifact produced in this workspace has digest:

```text
9151b9891772ca81513f49b04505009d472ce2a170473f4509934674daf1aade
```

## First steps inside the live session

The login session uses the live-build analyst account configured by the image. Start with `sentinel-audit ~/audit.txt` for a local defensive baseline, then inspect network state and packet captures before performing any scoped assessment. Store evidence only in the approved case directory and avoid copying secrets or personal data into reports.

## Build reproducibility

The source configuration is in the project directory. `build.sh` installs host prerequisites, stages Debian boot assets, applies the deterministic live-build configuration, creates `artifacts/ratan-os-amd64.iso`, writes `artifacts/SHA256SUMS` and enforces a 2,000,000,000-byte output ceiling.

## Validation note

The ISO has a bootable DOS/MBR system area and a BIOS El Torito `isolinux` entry. It was launched in a 20-second QEMU BIOS smoke test with 2 GiB RAM and two virtual CPUs; QEMU remained running until the controlled timeout and reported no fatal emulator error. The current image has **no UEFI El Torito entry**, so use QEMU BIOS/legacy mode as shown above. A future UEFI edition would require rebuilding with the GRUB bootloader and separately validating its EFI entry.
