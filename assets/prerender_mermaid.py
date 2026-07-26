#!/usr/bin/env python3
"""Pre-render Mermaid blocks in a Markdown file to inline SVG using mmdc.

Replaces both fenced ```mermaid blocks and <pre class="mermaid">...</pre> blocks
with the SVG mmdc produces, so the diagram is baked into the HTML (no CDN, works
offline and in print). Called by build.sh; a no-op if mmdc is unavailable.

Usage: prerender_mermaid.py <markdown_file> <workdir> <stem>
"""
import re
import subprocess
import sys
from pathlib import Path

md_path, workdir, stem = sys.argv[1], Path(sys.argv[2]), sys.argv[3]
text = Path(md_path).read_text()

# Mermaid theme config matching the brand (transparent boxes, currentColor-ish).
# mmdc bakes colours in, so we render for the dark site (off-white on transparent);
# the print stylesheet inverts the page, and the SVG strokes are set to a mid tone
# that reads on both. Kept simple and legible.
CONFIG = workdir / f"{stem}.mmdc.json"
CONFIG.write_text(
    '{"theme":"base","htmlLabels":false,'
    '"flowchart":{"htmlLabels":false},'
    '"class":{"htmlLabels":false},'
    '"themeVariables":{'
    '"fontFamily":"Arial, Helvetica, sans-serif",'
    '"primaryColor":"#ffffff00",'
    '"primaryBorderColor":"#3a4a42",'
    '"primaryTextColor":"#1b2721",'
    '"lineColor":"#5a6a62",'
    '"secondaryColor":"#ffffff00","tertiaryColor":"#ffffff00"}}'
)

counter = [0]

def render(source: str) -> str:
    counter[0] += 1
    inp = workdir / f"{stem}-{counter[0]}.mmd"
    out = workdir / f"{stem}-{counter[0]}.svg"
    inp.write_text(source.strip() + "\n")
    try:
        subprocess.run(
            ["mmdc", "-i", str(inp), "-o", str(out),
             "-c", str(CONFIG), "-b", "transparent"],
            check=True, capture_output=True,
        )
        svg = out.read_text()
        # strip XML prolog / doctype so it embeds inline cleanly
        svg = re.sub(r"<\?xml.*?\?>", "", svg, flags=re.S)
        svg = re.sub(r"<!DOCTYPE.*?>", "", svg, flags=re.S)
        return svg.strip()
    except Exception as e:  # noqa: BLE001
        sys.stderr.write(f"mermaid pre-render failed: {e}\n")
        return None

# 1) fenced ```mermaid blocks
def repl_fence(m):
    svg = render(m.group(1))
    return svg if svg else m.group(0)

text = re.sub(r"```mermaid\n(.*?)```", repl_fence, text, flags=re.S)

# 2) <pre class="mermaid">...</pre> blocks
def repl_pre(m):
    svg = render(m.group(1))
    return svg if svg else m.group(0)

text = re.sub(r'<pre class="mermaid">\n?(.*?)</pre>', repl_pre, text, flags=re.S)

Path(md_path).write_text(text)
