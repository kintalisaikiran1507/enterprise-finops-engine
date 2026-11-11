# Enterprise FinOps & Cloud Cost Engineering Engine

An open-source, code-first engineering repository tracking production FinOps patterns, billing data pipelines, and shift-left cost guardrails across AWS, Azure, and GCP.

## Architecture & Journey
- Billing Data Engineering:Ingesting and querying raw multi-cloud billing exports (FOCUS schema) using columnar Parquet files and DuckDB.
- Unit Economics Auditing:Normalizing invoice skew by separating Cash Outflow (`BilledCost`) from Amortized True Economics (`EffectiveCost`).
- Shift-Left Cost Intelligence:Pre-deployment PR cost diffing with Infracost and Terraform.

## Production Artifacts
- `sql/duckdb/01_esr_service_breakdown.sql`: Production DuckDB calculation parsing raw billing records to audit Effective Savings Rate (ESR) and amortized upfront commitment variance.
