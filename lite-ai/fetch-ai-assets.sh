#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RUNTIME_TAG="b10408"
RUNTIME_ARCHIVE="llama-${RUNTIME_TAG}-bin-ubuntu-x64.tar.gz"
RUNTIME_URL="https://github.com/ggml-org/llama.cpp/releases/download/${RUNTIME_TAG}/${RUNTIME_ARCHIVE}"
RUNTIME_SHA256="1740bcd80278d23c39130af4ba9ef9f11d867938ade7fb05b663db95752dbd6e"
MODEL_URL="https://huggingface.co/Qwen/Qwen3-4B-GGUF/resolve/main/Qwen3-4B-Q4_K_M.gguf?download=true"
MODEL_SIZE="2497280256"
MODEL_SHA256="7485fe6f11af29433bc51cab58009521f205840f5b4ae3a32fa7f92e8534fdf5"

VENDOR_DIR="${ROOT}/.vendor"
RUNTIME_DIR="${ROOT}/config/includes.chroot/usr/local/lib/ratan-ai"
MODEL_DIR="${ROOT}/config/includes.chroot/usr/local/share/ratan-ai/models"
MODEL_FILE="${MODEL_DIR}/Qwen3-4B-Q4_K_M.gguf"

require_command() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Required command not found: $1" >&2
    exit 2
  }
}

verify_runtime() {
  [[ -x "${RUNTIME_DIR}/llama-server" && -x "${RUNTIME_DIR}/llama-cli" ]]
}

verify_model() {
  [[ -f "$MODEL_FILE" ]] || return 1
  [[ "$(stat -c '%s' "$MODEL_FILE")" == "$MODEL_SIZE" ]] || return 1
  printf '%s  %s\n' "$MODEL_SHA256" "$MODEL_FILE" | sha256sum --check --status
}

stage_runtime() {
  local archive extracted
  archive="${VENDOR_DIR}/${RUNTIME_ARCHIVE}"
  extracted="${VENDOR_DIR}/llama-${RUNTIME_TAG}"
  mkdir -p "$VENDOR_DIR" "$RUNTIME_DIR" \
    "${ROOT}/config/includes.chroot/usr/share/doc/ratan-ai"

  if ! [[ -f "$archive" ]] || ! printf '%s  %s\n' "$RUNTIME_SHA256" "$archive" | sha256sum --check --status; then
    rm -f "$archive"
    curl --fail --location --retry 5 --retry-all-errors --output "$archive" "$RUNTIME_URL"
  fi
  printf '%s  %s\n' "$RUNTIME_SHA256" "$archive" | sha256sum --check --status

  rm -rf "$extracted"
  tar -xzf "$archive" -C "$VENDOR_DIR"
  rm -rf "$RUNTIME_DIR"
  mkdir -p "$RUNTIME_DIR"
  cp -a "${extracted}/llama-server" "${extracted}/llama-cli" "${extracted}"/*.so* "$RUNTIME_DIR/"
  cp -a "${extracted}/LICENSE" "${ROOT}/config/includes.chroot/usr/share/doc/ratan-ai/llama.cpp-LICENSE"
  chmod 0755 "${RUNTIME_DIR}/llama-server" "${RUNTIME_DIR}/llama-cli"
  rm -rf "$extracted"
}

stage_model() {
  local partial
  partial="${MODEL_FILE}.partial"
  mkdir -p "$MODEL_DIR"
  if verify_model; then
    echo "Qwen3-4B model already present and verified."
    return 0
  fi
  rm -f "$MODEL_FILE"
  curl --fail --location --retry 5 --retry-all-errors --continue-at - --output "$partial" "$MODEL_URL"
  [[ "$(stat -c '%s' "$partial")" == "$MODEL_SIZE" ]] || {
    echo "Model size verification failed." >&2
    exit 3
  }
  printf '%s  %s\n' "$MODEL_SHA256" "$partial" | sha256sum --check --status
  mv -f "$partial" "$MODEL_FILE"
  printf '%s  %s\n' "$MODEL_SHA256" "Qwen3-4B-Q4_K_M.gguf" > "${MODEL_FILE}.sha256"
}

require_command curl
require_command sha256sum
require_command tar

if verify_runtime; then
  echo "llama.cpp runtime already present."
else
  stage_runtime
fi
stage_model

echo "Verified offline AI assets are staged for the Ratan OS Lite AI Edition build."
