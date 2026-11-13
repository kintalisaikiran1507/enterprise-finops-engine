SELECT
	ProviderName,
	ServiceName,
	ROUND(SUM(COALESCE(ListCost,0)),2) AS total_list_cost,
	ROUND(SUM(COALESCE(EffectiveCost,0)),2) AS total_effective_cost,
	ROUND((1.0-(SUM(COALESCE(EffectiveCost,0)) / NULLIF(SUM(COALESCE(ListCost,0)),0)))*100,2) AS esr_pct
FROM read_parquet('~/finops-lab/FOCUS-Sample-Data/focus_billing.parquet')
WHERE ChargeCategory='Usage'
GROUP BY ProviderName,ServiceName
HAVING SUM(COALESCE(ListCost,0)) > 10
ORDER BY esr_pct DESC;
