#!/usr/bin/env bash
# Watch resume sources without requiring fswatch, inotify, or extra packages.
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$script_dir"

if [[ $# -gt 1 ]]; then
  echo "Usage: $0 [all|resume-{frontier|general}-{arch|full}]" >&2
  exit 2
fi

target="${1:-all}"
case "$target" in
  all|resume-frontier-arch|resume-frontier-full|resume-general-arch|resume-general-full|work-resume-frontier|work-resume-general) ;;
  *)
    echo "Unknown variant: $target" >&2
    echo "Usage: $0 [all|resume-{frontier|general}-{arch|full}]" >&2
    exit 2
    ;;
esac

trap 'echo; echo "Stopped watching."; exit 130' INT
trap 'echo "Stopped watching."; exit 143' TERM

# Hash only build inputs: generated PDFs and logs must not trigger rebuilds.
# Content hashes also detect additions, deletions, and timestamp-preserving saves.
source_signature() {
  find . -type d \( -name .git -o -name tmp -o -name output -o -name _site \) -prune -o \
    -type f \( -name '*.tex' -o -name '*.sty' -o -name '*.cls' \
    -o -name '*.ttf' -o -name '*.otf' -o -name '*.ttc' \
    -o -name 'build.sh' \) -exec cksum {} + | LC_ALL=C sort | cksum
}

rebuild() {
  echo "[$(date '+%H:%M:%S')] Building: $target"
  if bash "$script_dir/build.sh" "$target"; then
    echo "Watching for changes (Ctrl+C to stop)."
  else
    echo "Build failed; still watching. Save a correction to retry." >&2
  fi
}

echo "Watching TeX sources, fonts, and build.sh in: $script_dir"
previous_signature="$(source_signature)"
rebuild

while true; do
  sleep 1
  # An editor may replace a file while find is reading it; retry next poll.
  if ! current_signature="$(source_signature)"; then
    continue
  fi
  if [[ "$current_signature" != "$previous_signature" ]]; then
    # Coalesce rapid consecutive saves before starting the next compilation.
    sleep 1
    if ! current_signature="$(source_signature)"; then
      continue
    fi
    previous_signature="$current_signature"
    rebuild
    # Saves made during compilation are detected on the next poll.
  fi
done
