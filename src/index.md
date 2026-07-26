---
title: "Open Corporate Carbon Footprint Data Model"
subtitle: "A common, machine-readable structure for exchanging GHG Protocol-aligned carbon footprints between systems: open, CC0, and framework-agnostic."
description: "OpenCCF is an open, CC0 data model for exchanging corporate carbon footprint data between software systems, aligned with the GHG Protocol."
---

Carbon accounting frameworks (CSRD, IFRS S2, the GHG Protocol, SBTi) define what companies must report and how emissions should be calculated. However, these frameworks do not define how that data should be *structured*, so that one system can hand it to another without laborious custom integrations or data re-entry.

OpenCCF fills that gap. It's a common data model for corporate greenhouse gas footprints, built on the GHG Protocol Corporate Standard, so that calculators, ERPs, supply chain platforms and disclosure tools can exchange emissions data directly, without losing meaning and without requiring sender and receiver to agree on tooling first.

It doesn't replace any reporting framework or change how companies calculate emissions. It sits underneath them, as shared plumbing.

## Where to start

- **[White Paper](/white-paper/)**: why carbon accounting needs an interoperability layer, and where OpenCCF sits relative to existing frameworks and standards.
- **[Information Model](/information-model/)**: the conceptual structure of an Emissions Report and Emissions Line, and why it's shaped that way.
- **[Data Model](/data-model/)**: the implementable schema on GitHub, with field types, validation rules and worked examples, ready to integrate against.

## Status

OpenCCF is v0.3, a release candidate for v1.0, developed openly with input from partners across the carbon accounting industry. It's public domain under CC0 1.0, free to use, adapt and build on, no attribution required. Feedback and contributions are welcome via [GitHub](https://github.com/openccf/openccf-data-model).
