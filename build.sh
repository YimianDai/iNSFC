#!/usr/bin/env bash
# Build a CTeX (xeCJK) NSFC proposal: XeLaTeX -> BibTeX -> XeLaTeX -> XeLaTeX.

set -euo pipefail

# Named constants
TARGET=青A.tex
LATEX="xelatex -halt-on-error -interaction=nonstopmode"

usage() {
    cat <<EOF
Usage: $(basename "$0") [-h] [file.tex]

Compile an NSFC proposal with the standard XeLaTeX -> BibTeX -> XeLaTeX
-> XeLaTeX chain (required for xeCJK + the gbt7714-nsfc bibliography).

Defaults to '$TARGET' when no file is given.

Note: config.tex loads the 'bibunits' package while the document also
uses a plain \\bibliography, so each XeLaTeX run writes a duplicate
\\bibstyle/\\bibdata block into the .aux that BibTeX rejects. This script
strips the duplicate block from the .aux right before calling BibTeX.

Options:
  -h, --help    Show this message and exit
EOF
}

for arg in "$@"; do
    case "$arg" in
        -h|--help) usage; exit 0 ;;
        -*) echo "error: unknown option '$arg'" >&2; usage >&2; exit 1 ;;
        *) TARGET=$arg ;;
    esac
done

cd "$(dirname "$0")"

if [[ ! -f "$TARGET" ]]; then
    echo "error: '$TARGET' not found" >&2
    exit 1
fi

JOB=${TARGET%.tex}
AUX=$JOB.aux

# Pass 1: generate the .aux (records \citation commands).
$LATEX "$TARGET"

# Drop the duplicate \bibstyle / \@input{bu.aux} / \bibdata block left by the
# bibunits-vs-\bibliography conflict; keep only the first occurrence of each.
awk '!(/^\\bibstyle\{/ || /^\\@input\{bu\.aux\}/ || /^\\bibdata\{/) || !seen[$0]++' \
    "$AUX" > "$AUX.tmp" && mv "$AUX.tmp" "$AUX"

# Resolve the bibliography, then two more passes to settle citations/refs.
bibtex "$JOB"
$LATEX "$TARGET"
$LATEX "$TARGET"

# Append last-3pages.pdf to the end of the built PDF.
APPEND=last-3pages.pdf
if [[ -f "$APPEND" ]]; then
    pdfunite "$JOB.pdf" "$APPEND" "$JOB.pdf.tmp" && mv "$JOB.pdf.tmp" "$JOB.pdf"
    echo "build: appended '$APPEND' to '$JOB.pdf'" >&2
else
    echo "warning: '$APPEND' not found; skipping append" >&2
fi

echo "build: '$JOB.pdf' is up to date" >&2
