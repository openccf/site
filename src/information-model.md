---
title: "OpenCCF Information Model"
subtitle: "The conceptual structure for exchanging GHG Protocol-aligned corporate carbon footprints."
doctype: "Information Model"
seotitle: "OpenCCF Information Model: the structure of a corporate carbon footprint"
description: "The conceptual model underlying OpenCCF: how an emissions report, its emission lines, scopes, categories and provenance fit together for GHG Protocol-aligned data exchange."
toc: true
mermaid: true
pdf: true
---

*New here? Start with the [White Paper](/white-paper/) for why this model exists. For field-level types, required/optional status, permitted values and validation rules, see the [Data Model](/data-model/), the implementable version of this conceptual model.*

## 1. Scope and structure
This information model supports **corporate greenhouse gas footprints**
aligned with the **GHG Protocol Corporate Standard** including **all
associated guidance as of February 2026** and is designed to be
compatible with any software and reporting standard or framework that
handles GHG-compliant organisational GHG footprints. Note that the model
is designed to be flexible - it can be used for handling complete
end-of-year reporting or for single lines of specific emissions data
between compliant systems, with equal facility. The structure is
designed to be stable and extensible, ensuring backwards and forwards
compatibility with any GHG Protocol-compliant toolset.

***Note:** This draft defines the conceptual data structure and required
logical fields. Specific field names, data types, enumerations, and
proposed implementation syntax is defined in the v1 data model
specification.*

This structure is designed to support the transmission of the following
data, at a high level:

- **Scope 1**
    - Stationary fuel combustion
    - Mobile fuel combustion
    - Process emissions
    - Fugitive emissions
- **Scope 2**
    - Purchased electricity (both market- and location-based)
    - Purchased heat, steam and cooling
- **Scope 3**
    - All GHG Protocol Scope 3 categories (1-15)
    - "Not specified" is available under any scope where the source discloses no category breakdown

The structure consists of two core objects:

1.  **Emissions Report** (the container)

2.  **Emissions Line** (repeatable line items within a report)

***Note:*** *Emissions of biogenic origin are reported within Scopes 1-3
as applicable and are distinguished using the Emission origin field.
Land-related emissions and removals are reported explicitly using the
Accounting type and related metadata fields (e.g. gross CO₂ fluxes,
removals, and reversals).*

## 2. Emissions Report (report-level data)
An *Emissions Report* represents a company’s greenhouse gas footprint
for a defined reporting period.

### Fields (required unless marked optional)
- **Report Identifier**

- **Schema version**: The OpenCCF schema version this report was built against (e.g. 1.0.0), so a receiving system can tell which version to interpret it with.

- **Company name**: Legal or trading name of the reporting entity.

- **Sector (Classification System & Value - optional)**: Standardised sector classification (e.g. GHG Protocol sector, NACE, SIC, or equivalent; multiple supported).

- **Company Identifier (Classification System & Value - optional)**: Standardised company classification (e.g. LEI, DUNS number, or internal ID).

- **Primary location**: Location of the reporting entity, as an ISO 3166-1 country code, optionally extended with a state/province (ISO 3166-2) or city/place (UN/LOCODE) code, e.g. `GB`, `US-CA`, `GB-LON`.

- **Reporting period start date**

- **Reporting period end date**

- **Total net emissions - location-based (kgCO₂e)**: Net aggregate of emissions and removals for the reporting period, with gross emissions, removals, and reversals available at line level (always reported). This total excludes market-based electricity if provided.

- **Total net emissions - market-based (kgCO₂e)**: Net aggregate of emissions and removals for the reporting period, with gross emissions, removals, and reversals available at line level (if market-based Scope 2 electricity reported). This total excludes location-based electricity..

- **Emissions GWP basis (time horizon)**
    - Specify methodology used to calculate CO2 equivalencies
    - GWP20, GWP100 or GWP500

- **Report status**: One of:
    - Incomplete (e.g. not for utilisation as a full company report)
    - Self-completed
    - Third-party completed (including 3rd-party identification & accreditation details)
    - Third-party audited (including 3rd-party identification & accreditation details)

### Optional contextual fields
- **Reported intensity denominators**: One or more denominators to be provided for calculation of intensity values for the reporting period (e.g. average full-time employees, revenue, facility area, or other defined denominator), specified from standardised list.

## 3. Emissions Line (line-level data)
An *Emissions Line* represents a single quantified source or category of
emissions within a report. A report contains one or more lines, and
lines can be summed, or grouped by scope, category or other fields, to
produce totals and subtotals as required.

Each Emissions Report contains **one or more** Emissions Lines.

*In the Data Model, this containment is the `emissionsLines` field on Emissions Report: an array holding each Emissions Line's full data directly, not a summary or a reference to it stored elsewhere. This is the only place that data exists. See the [Data Model](/data-model/) for the field-level structure.*

### Fields (required unless marked optional)
- **Scope**: One of:
    - Scope 1
    - Scope 2
    - Scope 3

- **Category**
    - Scope 1: Stationary fuel, Mobile fuel, Process emissions, Fugitive gases
    - Scope 2: Electricity (market flag), Electricity (location flag), Heat, steam & cooling
    - Scope 3: GHG Protocol category (1-15)
    - Not specified

- **Subcategory (optional)**
    - Optional free-text subcategorisation of the line within its category, at the sender's discretion (e.g. "Food and beverages" or "HGV fleet"). There is no controlled vocabulary; values are descriptive and not intended to be machine-comparable across senders. Useful for breaking a category into meaningful detail without changing its GHG Protocol classification
    - and, unlike the free-text description on activityData, it is intended as a grouping label a sender can use to aggregate or subtotal their own lines (e.g. summing all "HGV fleet" lines). It describes the kind of line, not the specific activity quantity used to calculate it.

- **Line status**: Completeness of the emission line. Assurance status is recorded at report level. One of:
    - Complete
    - Incomplete (e.g. explicitly excluded from the report)
    - Excluded

- **Emissions quantity (kgCO₂e)**
    - Total CO₂-equivalent emissions attributed to this line, calculated in accordance with the emission factor and GWP basis specified.
    - Emissions are non-negative magnitudes and direction comes from Accounting type

- **Emission origin**
    - Fossil
    - Biogenic
    - Mixed (origin cannot be disaggregated in the data source used)
    - Not specified (data not available)
    - Not applicable (origin concept not relevant for this gas) *Emission origin should be provided where known and material; “Not specified” may be used where underlying data does not distinguish origin. If gas breakdown (below) is provided, gas-level origin shall take precedence.*

- **Accounting type**: One of (codified):
    - Emission
    - Removal
    - Gross CO₂ flux (additional disclosure)
    - Reversal (where applicable)
    - Other land sector disclosure (reserved for future expansion)

- **Location of emission**: Country or region where emissions physically occurred, as an ISO 3166-1 country code, optionally extended with a state/province (ISO 3166-2) or city/place (UN/LOCODE) code, e.g. `GB`, `US-CA`, `GB-LON`.

- **Facility associated with emission (optional)**: Facility where emissions physically occurred

- **Emission factor (optional)**
    - Reference to the authority used (e.g. government body, international institution, sector-specific source
    - unconstrained field but standardised list of commonly utilised sources to be made available).
    - Includes details including value, unit, source, year, dataset (e.g. government-issued emission factor set, international database, sector-specific dataset
    - unconstrained field but standardised list of commonly utilised sources to be made available) and methodology (used to calculate CO2 equivalencies
    - e.g. IPCC AR4, AR5 or AR6)

- **Data quality (optional)**: Codified indicator describing the nature and quality of the data used. Values to be defined in the Data Model and aligned to existing GHG Protocol guidance. Expected to cover technology, period, geography, completeness and reliability per the GHG Protocol.

- **Data quality information (optional)**: Free-text field for additional data quality context the sender wishes to convey that is not captured by the codified field above (e.g. narrative on estimation approach, source provenance, or known limitations). Provided at the sender's discretion; not intended to be machine-comparable. Examples include CO₂-only vs CO₂e estimates; Category-specific qualifiers (e.g. radiative forcing uplift applied for aviation, estimation methodology used for Scope 3.1/3.2); underlying quality of activity data (e.g. complete, extrapolated or estimated).

**Optional: Gas breakdown (repeatable)**

- **Gas CO₂e contribution (kgCO₂e)**: Portion of the total emissions quantity attributable to this gas.

- **Gas (multiple can be included)**
    - CO₂
    - CH₄
    - N₂O
    - HFC (with subtype)
    - PFC
    - SF₆
    - NF₃
    - Other (specified)

- **Gas quantity**: Quantity of the gas emitted in its native unit (e.g. tonnes CH₄).

- **Emission origin**
    - Fossil
    - Biogenic
    - Mixed (origin cannot be disaggregated in the data source used)
    - Not specified (data not available)
    - Not applicable (origin concept not relevant for this gas)

*Where gas breakdown is provided, the sum of gas-level CO₂e
contributions shall equal the Emissions quantity.*

### Optional: Activity information
- **Activity description**: Free-text or controlled description of the emitting activity.

- **Lifecycle stage (LCA stage)**: Where applicable (e.g. upstream, use phase, end-of-life).

- **Activity data value**: Quantitative activity input used to calculate emissions.

- **Activity data unit**: Unit corresponding to the activity data value.

## Optional: Land sector and removals {.unnumbered .unlisted}
- **Land boundary / traceability level (optional)**: Codified indicator of the boundary used for land-related lines (e.g. global / jurisdiction / sourcing region / land management unit), where applicable.

- **Storage duration / permanence (optional)**: Expected duration category for storage associated with removals/carbon storage claims, where applicable.

- **Monitoring / reversal treatment (optional)**: Codified indicator of monitoring approach and how reversals are handled (including if monitoring ceases), where applicable.

<figure class="diagram wide">
<!--INCLUDE:openccf-uml.svg-->
<figcaption>OpenCCF structure: the Emissions Report container, its repeatable Emissions Lines, and their nested detail objects.</figcaption>
</figure>



## 4. Design principles embedded in the model
- **Incomplete data is first-class**: Reports and lines explicitly support partial coverage and quality signalling.

- **Accounting-aligned, framework-agnostic**: The model reflects GHG Protocol accounting concepts without embedding reporting or disclosure rules.

- **Interoperable by default**: All fields are designed to be machine-readable and reusable across systems (specifics of fields names to come).

- **Extensible**: Future categories (e.g. forestry coverage) and additional metadata can be added without breaking existing implementations.

## 5. Intended use
This model defines **what is exchanged and how**, not **what must be
reported**, which will typically be a sub-set of the data defined in the
final data model, nor **whether it is exchanged** or with what **data
permissions**, which must be handled separately by the sender and
receiver of data.

It is intended to support:

- Software-to-software data exchange

- Scope 3 data sharing between organisations

- Reuse across reporting, finance, procurement, and analytics systems

- Roll-up into existing reporting frameworks and standards

## Appendix: Architectural Rationale
This model is intentionally multi-dimensional. It separates the core
accounting axes defined by the GHG Protocol into distinct,
non-overlapping fields to ensure interoperability, extensibility, and
mathematical consistency.

The primary dimensions are:

- **Scope - organisational boundary classification (Scope 1, 2, 3).**

- **Category / Subcategory - source classification within a scope.**

- **Accounting type - inventory treatment (Emission, Removal, Gross CO₂ flux, Reversal).**

- **Emissions quantity (kgCO₂e) - aggregated climate impact value for the line.**

- **Emission origin - fossil, biogenic, or mixed distinction (where relevant).**

- **Gas breakdown (optional) - constituent gas-level resolution.**

Each dimension answers a different accounting question:

- *Where does it sit in the organisational boundary?* Scope

- *What type of activity generated it?* Category

- *How is it treated in inventory terms?* Accounting type

- *What is its total climate impact?* Emissions quantity

- *What is the carbon origin?* Emission origin

- *What gases comprise it?* Gas breakdown

By separating these dimensions:

1.  No single field carries multiple semantic meanings.

2.  Land sector guidance integrates without redefining scope.

3.  Biogenic treatment does not require scope reclassification.

4.  Gas-level precision is supported but not required.

5.  Aggregated CO₂e reporting remains simple and valid.

The model therefore supports both:

- Minimal corporate disclosures (e.g corporate CO₂e annual reports, single CO₂e values per category), and

- High-resolution inventories (gas-resolved, origin-resolved, land-boundary-aware datasets).

This dimensional separation is designed to allow software systems to
exchange emissions data without loss of meaning, while supporting any
existing GHG Protocol-compliant tools and reporting frameworks.

*See the [Data Model](/data-model/) for this structure implemented as a validated schema.*
