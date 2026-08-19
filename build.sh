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
t = pathlib.Path(work).read_text(encoding="utf-8")
def repl(m):
    p = pathlib.Path(assets) / m.group(1)
    svg = p.read_text(encoding="utf-8")
    svg = re.sub(r"<\\?xml.*?\\?>", "", svg, flags=re.S)
    svg = re.sub(r"<!DOCTYPE.*?>", "", svg, flags=re.S)
    return svg.strip()
t = re.sub(r"<!--INCLUDE:([^>]+?)-->", repl, t)
pathlib.Path(work).write_text(t, encoding="utf-8", newline="\n")
PYINC
  local outdir="$DIST/$stem" disp="$stem/index.html" outfile=""
  if [ "$stem" = "index" ]; then outdir="$DIST"; disp="index.html"; fi
  if [ "$stem" = "404" ]; then outdir="$DIST"; disp="404.html"; fi
  outfile="$outdir/index.html"
  if [ "$stem" = "404" ]; then outfile="$outdir/404.html"; fi
  mkdir -p "$outdir"
  echo "-> $disp"
  # canonical / og:url for indexable pages (the 404 page has none)
  local url_flags=""
  local pageurl="$SITEURL/$stem/"
  if [ "$stem" = "index" ]; then pageurl="$SITEURL/"; fi
  if [ "$stem" != "404" ]; then url_flags="--variable pageurl:$pageurl"; fi
  local toc_flags=""
  grep -q '^toc: true' "$md" && toc_flags="--toc --toc-depth=2"
  # the PDF link is driven by the source frontmatter; actually (re)generating
  # the PDF additionally needs headless Chrome, so building on a machine
  # without Chrome keeps the committed PDFs and their download links intact
  local has_pdf=0 pdf_flag=""
  if grep -q '^pdf: true' "$md"; then
    has_pdf=1; pdf_flag="--variable pdfhref:$stem.pdf"
  fi
  pandoc "$work" --from gfm+attributes --to html5 --standalone --eol=lf $toc_flags $pdf_flag $url_flags \
    --template "$TEMPLATE" --variable "styles:$CSS" --variable "wordmark:$WORDMARK" \
    --variable "nav-$stem:true" --output "$outfile"
  # off-site links open in a new tab; internal links (root-relative) stay same-tab
  python3 - "$outfile" << 'PYEXT'
import re, sys, pathlib
p = pathlib.Path(sys.argv[1])
t = p.read_text(encoding="utf-8")
t = re.sub(r'(<a\s+href="https?://[^"]*")>', r'\1 target="_blank" rel="noopener">', t)
p.write_text(t, encoding="utf-8", newline="\n")
PYEXT
  if [ "$has_pdf" = "1" ] && [ -n "$CHROME" ]; then
    echo "-> ${disp%index.html}$stem.pdf"
    # standalone PDF: root-relative links need to be absolute to work outside the site
    local pdfsrc="$HERE/.build/$stem.pdf-src.html"
    python3 - "$outfile" "$pdfsrc" "$SITEURL" << 'PYABS'
import re, sys, pathlib
src, dst, siteurl = sys.argv[1], sys.argv[2], sys.argv[3]
t = pathlib.Path(src).read_text(encoding="utf-8")
t = re.sub(r'href="/(?!/)', f'href="{siteurl}/', t)
pathlib.Path(dst).write_text(t, encoding="utf-8", newline="\n")
PYABS
    "$CHROME" --headless --disable-gpu --no-sandbox \
      --print-to-pdf="$outdir/$stem.pdf" --no-pdf-header-footer \
      "file://$pdfsrc" >/dev/null 2>&1 || echo "   (PDF skipped; HTML built)"
  fi
}
for f in "$SRC"/*.md; do build "$(basename "$f" .md)"; done
cp "$ASSETS"/*.svg "$DIST"/ 2>/dev/null || true
cp "$ASSETS/favicon.ico" "$ASSETS/apple-touch-icon.png" "$DIST"/ 2>/dev/null || true
cp "$ASSETS/og-card.png" "$DIST"/ 2>/dev/null || true

# sitemap: one <url> per indexable source page, kept in sync with src/
{
  echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
  for f in "$SRC"/*.md; do
    s="$(basename "$f" .md)"
    if [ "$s" = "404" ]; then continue; fi
    loc="$SITEURL/$s/"
    if [ "$s" = "index" ]; then loc="$SITEURL/"; fi
    echo "  <url><loc>$loc</loc></url>"
  done
  echo '</urlset>'
} > "$DIST/sitemap.xml"
echo "-> sitemap.xml"
mkdir -p "$DIST/partners" && cp "$ASSETS"/partners/* "$DIST/partners"/ 2>/dev/null || true
echo; echo "Built $(find "$DIST" -maxdepth 2 -name index.html 2>/dev/null | wc -l | tr -d ' ') page(s)"
[ "$have_mmdc" -eq 1 ] || echo "note: mmdc not found - Mermaid left as client-side fallback."
[ -n "$CHROME" ]       || echo "note: no headless Chrome - PDFs not generated."
