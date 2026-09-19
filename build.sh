#!/usr/bin/env bash
# Build the resume PDF with XeLaTeX. Run from any directory: ./build.sh
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

xelatex -interaction=nonstopmode -halt-on-error work-resume.tex
xelatex -interaction=nonstopmode -halt-on-error work-resume.tex

rm -f work-resume.aux work-resume.log work-resume.out
echo "Built: $script_dir/work-resume.pdf"
