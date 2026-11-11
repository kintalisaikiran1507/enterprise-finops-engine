-- Production FOCUS ESR Breakdown Query
-- Computes ListCost, BilledCost, EffectiveCost, Realized Savings, and Effective Savings Rate (ESR)

SELECT 
    ProviderName,
    ServiceName,
    ROUND(SUM(COALESCE(ListCost, 0)), 2) AS total_list_cost,
    ROUND(SUM(COALESCE(BilledCost, 0)), 2) AS total_billed_cost,
    ROUND(SUM(COALESCE(EffectiveCost, 0)), 2) AS total_effective_cost,
    ROUND(SUM(COALESCE(ListCost, 0) - COALESCE(EffectiveCost, 0)), 2) AS realized_savings,
    ROUND((1.0 - (SUM(COALESCE(EffectiveCost, 0)) / NULLIF(SUM(COALESCE(ListCost, 0)), 0))) * 100, 2) AS esr_pct
FROM read_parquet('focus_billing.parquet')
WHERE ChargeCategory = 'Usage'
  AND ListCost > 0
GROUP BY ProviderName, ServiceName
HAVING SUM(COALESCE(ListCost, 0)) > 50
ORDER BY total_effective_cost DESC;
