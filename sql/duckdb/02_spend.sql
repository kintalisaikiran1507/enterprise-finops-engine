SELECT 
	ProviderName,
	ServiceName AS RegionName,
	ROUND(SUM(COALESCE(BilledCost,0)),2) AS region_billed_cost,
	ROUND(SUM(COALESCE(EffectiveCost,0)),2) AS region_effective_cost
FROM read_parquet('~/finops-lab/FOCUS-Sample-Data/focus_billing.parquet')
WHERE ChargeCategory='Usage'
GROUP BY ProviderName,RegionName
ORDER BY region_effective_cost DESC Limit 5;
