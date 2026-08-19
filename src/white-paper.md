---
title: "Towards Harmonised, Interoperable Carbon Footprint Data"
subtitle: "A proposal for a shared, machine-readable data model for corporate and product carbon footprints."
doctype: "White Paper"
seotitle: "OpenCCF White Paper: interoperable carbon footprint data"
description: "Why carbon accounting needs an interoperability data model, distinct from reporting frameworks."
toc: true
pdf: true
---

## Executive summary

Global climate disclosure has reached a turning point. Regulatory and voluntary frameworks have improved what companies must report, but they stop short of defining how carbon footprint data should be exchanged between organisations. As a result, companies, investors and government agencies face growing friction when attempting to share, reuse, or aggregate emissions data across value chains.

This paper argues that the next critical step is the creation of an interoperability data model (not another reporting or disclosure framework) capable of enabling machine-readable, consistent and trustworthy exchange of both corporate and product carbon footprints. It is proposed that this model should be developed in line with the approach taken with other interoperability models such as TCP/IP (for internet communication) or IBAN (for international money transfers): following open data principles, and inviting engagement and contribution from all who seek low-friction exchange of carbon data, particularly those developing standards, platforms and initiatives that would benefit from a shared, interoperable data foundation.

## Data models are not reporting frameworks

Most existing carbon standards serve a similar purpose. CSRD and its ESRS define regulatory disclosure requirements. ISO standards define methodological consistency. SBTi provides a standard for establishing targets and trajectories. All of these ultimately reference the GHG Protocol as defining the standards for emissions accounting.

These initiatives are indispensable. However, they all operate primarily at the level of interpretation, aggregation and disclosure, and are not designed to coordinate with one another through a shared, machine-readable data layer.

In practice, this means that two companies can both be fully compliant with the same framework, yet still be unable to reuse each other's emissions data without manual intervention, reinterpretation, or re-calculation. Emissions are disclosed as totals, narratives, or tagged figures, rather than as structured datasets with clear semantics.

A standardised data model answers a different question. It does not ask whether emissions have been reported correctly, but whether they can be understood, ingested and reused by another system without loss of meaning.

## Why interoperability now matters

This distinction has become urgent for three reasons.

**First, Scope 3 emissions are beginning to dominate corporate footprints.** As corporate footprinting matures, companies increasingly depend on emissions data from suppliers and partners, rather than on calculations they control themselves. Suppliers are asked by vendors to provide data in an uncoordinated way that puts increasing pressure on non-expert people to gather and submit data in various inconsistent formats. Without a shared data model that provides both core GHG Protocol-compliant accounting CO₂e values and associated metadata regarding methodology, Scope 3 exchange remains fragmented, inefficient and ultimately inaccurate.

**Second, sustainability reporting is becoming digital by default.** APIs, automated validation and near-real-time analytics are replacing static report documents. Interoperability is thus no longer a "nice to have"; it is a prerequisite for interaction between organisations, investors and governments, and a benefit to all platforms that seek to help companies calculate, report, target-set and track their GHG emissions.

**Third, product-level carbon footprints are moving from niche use cases to commercial relevance.** Procurement, eco-design and customer disclosure all depend on the ability to exchange product footprint data in a consistent form. Although there are emerging standards that will help, this exchange is largely ad hoc and highly variable, suffering the same issues facing corporate GHG data exchange described above.

## What a standardised carbon data model would do


<figure class="sidebar">
<svg viewBox="0 0 640 918" xmlns="http://www.w3.org/2000/svg" font-family="Arial, Helvetica, sans-serif" role="img" aria-label="Four-layer carbon data stack; OpenCCF occupies Layer 2, the GHG accounting data interoperability layer.">
<rect x="8" y="8" width="624" height="206" rx="14" fill="none" stroke="currentColor" stroke-width="1.5"/>
<text x="30" y="34" font-weight="700" font-size="15" fill="currentColor">Layer 4: Disclosure & Reporting Frameworks</text>
<text x="30" y="54" font-size="13.5" fill="currentColor" opacity="0.85">What must be reported</text>
<text x="30" y="84" font-size="13" font-weight="700" fill="currentColor">Examples:</text>
<text x="30" y="104" font-size="13" fill="currentColor">• IFRS S2 (ISSB)</text>
<text x="30" y="124" font-size="13" fill="currentColor">• CSRD / ESRS</text>
<text x="30" y="144" font-size="13" fill="currentColor">• B4NZ</text>
<text x="30" y="164" font-size="13" fill="currentColor">• SEC climate disclosures</text>
<text x="30" y="184" font-size="13" fill="currentColor">• CDP</text>
<line x1="320.0" y1="214" x2="320.0" y2="240" stroke="currentColor" stroke-width="1.5"/>
<rect x="8" y="240" width="624" height="166" rx="14" fill="none" stroke="currentColor" stroke-width="1.5"/>
<text x="30" y="266" font-weight="700" font-size="15" fill="currentColor">Layer 3: Digital Filing & Reporting Formats</text>
<text x="30" y="286" font-size="13.5" fill="currentColor" opacity="0.85">How reported data is encoded and transmitted</text>
<text x="30" y="316" font-size="13" font-weight="700" fill="currentColor">Examples:</text>
<text x="30" y="336" font-size="13" fill="currentColor">• XBRL taxonomies</text>
<text x="30" y="356" font-size="13" fill="currentColor">• ESEF</text>
<text x="30" y="376" font-size="13" fill="currentColor">• Regulatory and procurement platform APIs</text>
<line x1="320.0" y1="406" x2="320.0" y2="432" stroke="currentColor" stroke-width="1.5"/>
<rect x="8" y="432" width="624" height="226" rx="14" fill="currentColor" stroke="currentColor" stroke-width="1.5"/>
<text x="30" y="458" font-weight="700" font-size="15" fill="var(--panel-fg, #14201b)">Layer 2: GHG Accounting Data Interoperability Layer</text>
<text x="30" y="478" font-size="13.5" fill="var(--panel-fg, #14201b)" opacity="0.85">How emissions data is structured for exchange between software systems</text>
<text x="30" y="508" font-size="13" font-weight="700" fill="var(--panel-fg, #14201b)">Proposed:</text>
<text x="30" y="528" font-size="13" fill="var(--panel-fg, #14201b)">• Corporate GHG data interoperability schema</text>
<text x="30" y="548" font-size="13" fill="var(--panel-fg, #14201b)">• Handles any GHG Protocol-aligned inventory structure</text>
<text x="30" y="568" font-size="13" fill="var(--panel-fg, #14201b)">• Represents complete or partial datasets</text>
<text x="30" y="588" font-size="13" fill="var(--panel-fg, #14201b)">• Methodology-neutral (IFRS, CSRD, CDP, B4NZ, etc.)</text>
<text x="30" y="608" font-size="13" fill="var(--panel-fg, #14201b)">• Transport-agnostic (XBRL, APIs, JSON, CSV, etc.)</text>
<text x="30" y="628" font-size="13" fill="var(--panel-fg, #14201b)">• Extensible to incorporate future guidance</text>
<line x1="320.0" y1="658" x2="320.0" y2="684" stroke="currentColor" stroke-width="1.5"/>
<rect x="8" y="684" width="624" height="226" rx="14" fill="none" stroke="currentColor" stroke-width="1.5"/>
<text x="30" y="710" font-weight="700" font-size="15" fill="currentColor">Layer 1: Calculation & Data Generation Systems</text>
<text x="30" y="730" font-size="13.5" fill="currentColor" opacity="0.85">Where emissions are calculated and managed</text>
<text x="30" y="760" font-size="13" font-weight="700" fill="currentColor">Examples:</text>
<text x="30" y="780" font-size="13" fill="currentColor">• Calculators (e.g. Watershed, Sage, SME Climate Hub)</text>
<text x="30" y="800" font-size="13" fill="currentColor">• Corporate ERP systems</text>
<text x="30" y="820" font-size="13" fill="currentColor">• LCA tools</text>
<text x="30" y="840" font-size="13" fill="currentColor">• EF databases & APIs (e.g. EXIOBASE, Climatiq, ecoinvent)</text>
<text x="30" y="860" font-size="13" fill="currentColor">• Supply chain data networks (e.g. Mycelium Networks, Ditch)</text>
<text x="30" y="880" font-size="13" fill="currentColor">• Consultant-built inventory models</text>
</svg>
<figcaption>The carbon data stack. OpenCCF occupies Layer 2, the interoperability layer between calculation systems below and reporting frameworks above.</figcaption>
</figure>

A standardised carbon footprint information model would not redefine accounting rules or supersede existing frameworks. Rather, it would operationalise them and allow the data necessary for each of them to be exchanged in a predictable way, enabling existing and emerging initiatives to interoperate without requiring alignment on governance, policy, or use case.

At the corporate level, such a model would allow companies to share emissions data in a structured form that includes not only totals, but also essential context: scope and category breakdowns, time periods, locations, data quality indicators, completeness signals, and methodological provenance. This enables downstream users to understand how reliable the data is and how it can be reused, without forcing full methodological alignment.

At the line level, it would enable emissions to be described consistently using common fields (such as scope, category, lifecycle stage where relevant, emissions quantity, location, and emission factor metadata) while leaving room for optional disclosure of activity data where appropriate, allowing recalculation of, for example, alternative values for flight emissions if required.

As a note, a future data model along similar lines could be developed for product carbon footprints, to provide a neutral carrier for lifecycle-based footprint data aligned with the GHG Protocol Product Standard and ISO 14067, while remaining compatible with derived approaches such as PEF or PACT. The aim is not to lock companies into a single methodology, nor to duplicate existing initiatives, but to ensure that underlying data can move cleanly between systems.

## Designed for evolution

Carbon accounting is not static. Guidance on land use, biogenic carbon and removals is evolving rapidly, as are expectations around data quality and uncertainty. A carbon data model must therefore be extensible and versioned, able to incorporate new categories and definitions without breaking existing integrations or constraining parallel initiatives as they evolve.

This flexibility is difficult to achieve in aggregation-first reporting frameworks, but far easier at the data layer, where it can align with the actual collection and transformation of activity data into emissions estimations.

## Establishing a shared data foundation

We believe the sustainability ecosystem has a critical gap. Without a shared interoperability-oriented data model, the proliferation of platforms, tools and frameworks will continue to increase friction, duplication and cost.

Carbon accounting has built strong rules. Like other industries, such as global telecommunications (e.g. TCP/IP for the operation of the internet) and finance (e.g. IBAN for international transfers), it now needs shared infrastructure.

A common data model for corporate and product carbon footprints provides the foundation for interoperable, reusable emissions data that supports credible, scalable climate action. We propose this model be governed openly by the carbon accounting industry, and invite organisations developing related standards, platforms and schemes to engage in reviewing, shaping and piloting the proposed structure.

For our first step, we propose an open data model for Corporate Carbon Footprints, designed along the principles outlined in this paper: the **[OpenCCF Data Model](/data-model/)**.

*See the [Information Model](/information-model/) for the conceptual structure, or the [Data Model](/data-model/) for the implementable schema.*
