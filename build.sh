#!/usr/bin/env bash
# Build the OpenCCF site: Markdown -> branded HTML (+ optional PDF).
# One source per document in src/. Diagrams in ```mermaid or <pre class="mermaid">
# are pre-rendered to inline SVG at build time (mmdc) so they need no CDN.
#
# Requirements:
#   pandoc                          (brew install pandoc)
#   mmdc  (optional, diagrams)      (npm install -g @mermaid-js/mermaid-cli)
#   headless Chrome (optional, PDF) (Google Chrome / chromium)
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
SRC="$HERE/src"; ASSETS="$HERE/assets"; DIST="$HERE"
SITEURL="https://openccf.org"
mkdir -p "$HERE/.build"
CSS="$(cat "$ASSETS/openccf.css")"
WORDMARK="$(cat "$ASSETS/openccf-wordmark.svg")"
TEMPLATE="$ASSETS/template.html"

CHROME=""
for c in "google-chrome" "chromium" "chromium-browser" \
         "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"; do
  if command -v "$c" >/dev/null 2>&1 || [ -x "$c" ]; then CHROME="$c"; break; fi
done
have_mmdc=0; command -v mmdc >/dev/null 2>&1 && have_mmdc=1

build () {
  local stem="$1"; local md="$SRC/$stem.md"; local work="$HERE/.build/$stem.md"
  cp "$md" "$work"
  # inline any <!--INCLUDE:name.svg--> markers with the file from assets/
  python3 - "$work" "$ASSETS" << 'PYINC'
import re, sys, pathlib
work, assets = sys.argv[1], sys.argv[2]
t = pathlib.Path(work).read_text()
def repl(m):
    p = pathlib.Path(assets) / m.group(1)
    svg = p.read_text()
    svg = re.sub(r"<\\?xml.*?\\?>", "", svg, flags=re.S)
    svg = re.sub(r"<!DOCTYPE.*?>", "", svg, flags=re.S)
    return svg.strip()
t = re.sub(r"<!--INCLUDE:([^>]+?)-->", repl, t)
pathlib.Path(work).write_text(t)
PYINC
  local outdir="$DIST/$stem" disp="$stem/index.html"
  if [ "$stem" = "index" ]; then outdir="$DIST"; disp="index.html"; fi
  mkdir -p "$outdir"
  echo "-> $disp"
  local toc_flags=""
  grep -q '^toc: true' "$md" && toc_flags="--toc --toc-depth=2"
  local has_pdf=0 pdf_flag=""
  if [ -n "$CHROME" ] && grep -q '^pdf: true' "$md"; then
    has_pdf=1; pdf_flag="--variable pdfhref:$stem.pdf"
  fi
  pandoc "$work" --from gfm --to html5 --standalone $toc_flags $pdf_flag \
    --template "$TEMPLATE" --variable "styles:$CSS" --variable "wordmark:$WORDMARK" \
    --variable "nav-$stem:true" --output "$outdir/index.html"
  # off-site links open in a new tab; internal links (root-relative) stay same-tab
  python3 - "$outdir/index.html" << 'PYEXT'
import re, sys, pathlib
p = pathlib.Path(sys.argv[1])
t = p.read_text()
t = re.sub(r'(<a\s+href="https?://[^"]*")>', r'\1 target="_blank" rel="noopener">', t)
p.write_text(t)
PYEXT
  if [ "$has_pdf" = "1" ]; then
    echo "-> ${disp%index.html}$stem.pdf"
    # standalone PDF: root-relative links need to be absolute to work outside the site
    local pdfsrc="$HERE/.build/$stem.pdf-src.html"
    python3 - "$outdir/index.html" "$pdfsrc" "$SITEURL" << 'PYABS'
import re, sys, pathlib
src, dst, siteurl = sys.argv[1], sys.argv[2], sys.argv[3]
t = pathlib.Path(src).read_text()
t = re.sub(r'href="/(?!/)', f'href="{siteurl}/', t)
pathlib.Path(dst).write_text(t)
PYABS
    "$CHROME" --headless --disable-gpu --no-sandbox \
      --print-to-pdf="$outdir/$stem.pdf" --no-pdf-header-footer \
      "file://$pdfsrc" >/dev/null 2>&1 || echo "   (PDF skipped; HTML built)"
  fi
}
for f in "$SRC"/*.md; do build "$(basename "$f" .md)"; done
cp "$ASSETS"/*.svg "$DIST"/ 2>/dev/null || true
echo; echo "Built $(find "$DIST" -maxdepth 2 -name index.html 2>/dev/null | wc -l | tr -d ' ') page(s)"
[ "$have_mmdc" -eq 1 ] || echo "note: mmdc not found - Mermaid left as client-side fallback."
[ -n "$CHROME" ]       || echo "note: no headless Chrome - PDFs not generated."
