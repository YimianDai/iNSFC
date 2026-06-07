#!/usr/bin/env bash
# Clean up all LaTeX auxiliary/generated files
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

rm -f \
  .latexmkrc \
  *.aux \
  *.bbl \
  *.blg \
  *.log \
  *.out \
  *.toc \
  *.xdv \
  *.fls \
  *.fdb_latexmk \
  bu.aux \
  bu.bbl \
  bu.blg

echo "Cleaned $(basename "$DIR")/"


git rm --cache \
  .latexmkrc \
  *.aux \
  *.log \
  *.out \
  *.toc \
  *.xdv \
  *.fls \
  *.fdb_latexmk
