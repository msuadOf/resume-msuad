#!/usr/bin/env bash
# Build all variants, or one named variant, with XeLaTeX.
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$script_dir"

# Make a standard macOS TeX installation discoverable when launched from a GUI.
if [[ -x /usr/libexec/path_helper ]]; then
  eval "$(/usr/libexec/path_helper)"
fi

command -v xelatex >/dev/null || {
  echo "Error: XeLaTeX was not found. Install MacTeX, then run this script again." >&2
  exit 1
}

if [[ $# -gt 1 ]]; then
  echo "Usage: $0 [all|resume-{frontier|general}-{arch|full}]" >&2
  exit 2
fi

target="${1:-all}"
case "$target" in
  all)
    targets=(resume-frontier-arch resume-frontier-full resume-general-arch resume-general-full)
    ;;
  resume-frontier-arch|resume-frontier-full|resume-general-arch|resume-general-full|work-resume-frontier|work-resume-general)
    targets=("$target")
    ;;
  *)
    echo "Unknown variant: $target" >&2
    echo "Usage: $0 [all|resume-{frontier|general}-{arch|full}]" >&2
    exit 2
    ;;
esac

for resume in "${targets[@]}"; do
  for pass in 1 2; do
    if ! xelatex -interaction=nonstopmode -halt-on-error "$resume.tex" >"$resume.build.log" 2>&1; then
      cat "$resume.build.log" >&2
      echo "Build failed; retained $resume.log and $resume.build.log" >&2
      exit 1
    fi
  done
  rm -f "$resume.aux" "$resume.log" "$resume.out" "$resume.build.log"
  echo "Built: $script_dir/$resume.pdf"
done
