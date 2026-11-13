SELECT
	Providername,
	ROUND(SUM(COALESCE(EffectiveCost,0)),2) AS total_effective_cost,
	ROUND(SUM(
		CASE
			WHEN EffectiveCost<ListCost THEN EffectiveCost
			ELSE 0
		END
	
		),2) AS covered_spend,
	ROUND(SUM(
		CASE
			WHEN EffectiveCost>=ListCost THEN EffectiveCost
			ELSE 0
		END
	
		),2) AS leak_spend,
	
	ROUND((covered_spend/NULLIF(total_effective_cost,0))*100,2) AS coverage_pct

FROM read_parquet('~/finops-lab/FOCUS-Sample-Data/focus_billing.parquet')
WHERE ChargeCategory='Usage' AND ListCost > 0
GROUP BY ProviderName
ORDER BY total_effective_cost DESC;
