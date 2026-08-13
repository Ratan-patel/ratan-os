#!/usr/bin/env bash
set -Eeuo pipefail

ISO="${1:-artifacts/ratan-os-amd64.iso}"
[[ -f "$ISO" ]] || { echo "ISO not found: $ISO" >&2; exit 2; }

exec qemu-system-x86_64 \
  -M pc \
  -accel "${QEMU_ACCEL:-kvm}" \
  -m 2048 \
  -smp 2 \
  -cdrom "$ISO" \
  -boot order=d \
  -nic user,model=e1000 \
  -display gtk
