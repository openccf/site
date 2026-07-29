---
title: "Open Corporate Carbon Footprint Data Model"
subtitle: "A common, machine-readable structure for exchanging GHG Protocol-aligned carbon footprints between systems: open, CC0, and framework-agnostic."
description: "OpenCCF is an open, CC0 data model for exchanging corporate carbon footprint data between software systems, aligned with the GHG Protocol."
---

<aside class="callout">
  <h2>Start Building</h2>
  <p>The data model is a validated LinkML schema: JSON Schema, SHACL, OWL and Python generated from a single source, with worked examples and a test suite.</p>
  <a class="callout-cta" href="https://github.com/openccf/openccf-data-model" target="_blank" rel="noopener">
    <svg viewBox="0 0 16 16" width="18" height="18" fill="currentColor" aria-hidden="true"><path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.01 8.01 0 0 0 16 8c0-4.42-3.58-8-8-8z"/></svg>
    <span>View on GitHub</span>
  </a>
</aside>

Carbon accounting frameworks (CSRD, IFRS S2, the GHG Protocol, SBTi) define what companies must report and how emissions should be calculated. However, these frameworks do not define how that data should be *structured*, so that one system can hand it to another without laborious custom integrations or data re-entry.

OpenCCF fills that gap. It's a common data model for corporate greenhouse gas footprints, built on the GHG Protocol Corporate Standard, so that calculators, ERPs, supply chain platforms and disclosure tools can exchange emissions data directly, without losing meaning and without requiring sender and receiver to agree on tooling first.

It doesn't replace any reporting framework or change how companies calculate emissions. It sits underneath them, as shared plumbing.

## Where to start

- **[White Paper](/white-paper/)**: why carbon accounting needs an interoperability layer, and where OpenCCF sits relative to existing frameworks and standards.
- **[Information Model](/information-model/)**: the conceptual structure of an Emissions Report and Emissions Line, and why it's shaped that way.
- **[Data Model](/data-model/)**: the implementable schema on GitHub, with field types, validation rules and worked examples, ready to integrate against.

## Release Partners

<div class="partners-box">
  <a href="https://murmurate.digital"><img src="/partners/murmurate_logo.png" alt="Murmurate"></a>
  <a href="https://www.equipoise.earth/"><img src="/partners/equipoise.webp" alt="Equipoise"></a>
  <a href="https://www.roundarc.com/"><img src="/partners/roundarc_logo.png" alt="RoundArc"></a>
  <a href="https://mycelium.global/"><img src="/partners/Mycelium_logo.png" alt="Mycelium"></a>
</div>

## Status

OpenCCF is v0.3, a release candidate for v1.0, developed openly with input from partners across the carbon accounting industry. It's public domain under CC0 1.0, free to use, adapt and build on, no attribution required. Feedback and contributions are welcome via [GitHub](https://github.com/openccf/openccf-data-model).
