#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

if [[ "${EUID}" -eq 0 ]]; then
  echo "Build ko root ke roop mein na chalayein; live-build apne chroot steps ke liye sudo use karega." >&2
  exit 1
fi

if ! command -v lb >/dev/null 2>&1; then
  echo "live-build install karein: sudo apt-get update && sudo apt-get install -y live-build debootstrap"
  exit 2
fi

# Fetches only the explicitly pinned llama.cpp runtime and Qwen3-4B model.
./fetch-ai-assets.sh

sudo apt-get update
sudo apt-get install -y debootstrap squashfs-tools xorriso grub-pc-bin grub-efi-amd64-bin mtools dosfstools qemu-system-x86 isolinux syslinux-common syslinux syslinux-utils

# live-build's built-in isolinux config does not ship binary boot modules.
# Stage Debian-provided, unmodified boot assets into the reproducible config tree.
mkdir -p config/bootloaders/isolinux
if [[ -f /usr/lib/ISOLINUX/isolinux.bin ]]; then
  cp -f /usr/lib/ISOLINUX/isolinux.bin config/bootloaders/isolinux/isolinux.bin
elif [[ -f /usr/lib/syslinux/isolinux.bin ]]; then
  cp -f /usr/lib/syslinux/isolinux.bin config/bootloaders/isolinux/isolinux.bin
else
  echo "isolinux.bin not found after installing isolinux" >&2
  exit 5
fi
cp -f /usr/lib/syslinux/modules/bios/*.c32 config/bootloaders/isolinux/

# Purane generated state ko hata kar deterministic configuration se rebuild karein.
sudo lb clean --purge || true
./auto/config
sudo lb build 2>&1 | tee "artifacts/build.log"

ISO="$(find . -maxdepth 1 -type f -name '*.iso' -print -quit)"
if [[ -z "$ISO" ]]; then
  echo "ISO output nahi mila." >&2
  exit 3
fi

cp -f "$ISO" artifacts/ratan-os-lite-ai-amd64.iso
sha256sum artifacts/ratan-os-lite-ai-amd64.iso | tee artifacts/SHA256SUMS
ISO_BYTES="$(stat -c '%s' artifacts/ratan-os-lite-ai-amd64.iso)"
printf 'ISO bytes: %s\n' "$ISO_BYTES"
awk -v bytes="$ISO_BYTES" 'BEGIN { printf "ISO MiB: %.1f\\n", bytes / 1024 / 1024 }'
if (( ISO_BYTES > 3600000000 )); then
  echo "FAIL: AI Edition ISO 3.6 GB budget se bada hai." >&2
  exit 4
fi

echo "ISO taiyar hai: artifacts/ratan-os-lite-ai-amd64.iso"
