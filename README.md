# openccf.org

Source for [openccf.org](https://openccf.org), the home of OpenCCF (Open Corporate Carbon Footprint). The schema itself lives in
[openccf-data-model](https://github.com/openccf/openccf-data-model).

## How this site is built and deployed

There is no CI and no hosting build step. GitHub Pages serves the **root of the `main` branch as-is**, so whatever is committed
to `main` is what goes live (usually within a minute or two). The HTML and PDFs are generated locally by `build.sh` and
**committed to the repo**.

That means two kinds of file live side by side:

| You edit these (source) | These are generated (never edit by hand) |
| --- | --- |
| `src/*.md` (page content and frontmatter) | `index.html`, `404.html`, `*/index.html` |
| `assets/` (template, CSS, logos, favicons, OG card) | `partners/`, `sitemap.xml` |
| `build.sh` | `*/*.pdf`, root copies of assets (`favicon.*`, `og-card.png`, `*.svg`) |

If you edit a generated file directly, the change **will be silently overwritten** the next time anyone runs `./build.sh`.
Always change the source, rebuild, and commit both the source and the regenerated output.

## Making a change

Requirements: [pandoc](https://pandoc.org/). Optional: `mmdc` (pre-renders Mermaid diagrams) and headless Chrome (regenerates PDFs;
without it the committed PDFs are kept).

```sh
# 1. edit the source (src/ and/or assets/)
# 2. rebuild
./build.sh
# 3. preview locally
python3 -m http.server 8420     # then open http://localhost:8420
# 4. commit the source AND the regenerated files, then open a PR
```

Rebuilding regenerates the PDFs too, which changes their bytes (embedded timestamps) even when the content is identical. If you
did not touch `src/white-paper.md` or `src/information-model.md`, run `git checkout -- '*.pdf'` before committing to keep the diff clean.

## Adding or changing a partner logo

1. Put the image in `assets/partners/` (this is the source folder; `build.sh` copies it to the generated `partners/` folder).
   Keep it small (compress large PNGs) and use a transparent background where possible.
2. Add the `<a><img></a>` line to the right group ("Adopted by" or "Endorsed by") in `src/index.md`, pointing at
   `/partners/<filename>`.
3. Run `./build.sh` and commit `assets/partners/<file>`, `partners/<file>`, `src/index.md` and the regenerated `index.html`.

Please confirm the partner and their link with the maintainers before opening the PR.

## Licence

Content is public domain under [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/). Maintained by
[murmurate](https://www.murmurate.digital).
