DECLARE evaluation_period_start_date DATE DEFAULT DATE_SUB(CURRENT_DATE(), INTERVAL @reporting_interval_days DAY);
DECLARE evaluation_period_end_date DATE DEFAULT CURRENT_DATE();

WITH creative_performance_source_a AS (
  SELECT
    source.network AS network,
    product.product_name AS product_name,
    source.campaign_name AS campaign_name,
    COALESCE(creative.creative_name, source.creative_name_raw) AS creative_name,
    MIN(source.install_date) AS first_in_campaign_install_date,
    MAX(source.install_date) AS last_in_campaign_install_date,
    SUM(COALESCE(source.installs, 0)) AS tot_installs,
    SUM(COALESCE(source.impressions, 0)) AS tot_impressions,
    SUM(COALESCE(source.cost, 0)) AS tot_cost,
    SUM(COALESCE(source.value, 0)) AS tot_value
  FROM `project.dataset.performance_daily` AS source
  LEFT JOIN `project.dataset.creative_dimension` AS creative
    ON source.creative_id = creative.creative_id
  LEFT JOIN `project.dataset.product_dimension` AS product
    ON source.product_id = product.product_id
  WHERE
    source.install_date BETWEEN evaluation_period_start_date AND evaluation_period_end_date
    AND LOWER(source.campaign_name) LIKE "%test_campaign%"
    AND source.acquisition_category = "Paid"
  GROUP BY 1, 2, 3, 4
),

creative_performance_source_b AS (
  SELECT
    "Network B" AS network,
    product.product_name AS product_name,
    source.campaign_name AS campaign_name,
    REPLACE(source.asset_name, " ", "_") AS creative_name,
    MIN(source.install_date) AS first_in_campaign_install_date,
    MAX(source.install_date) AS last_in_campaign_install_date,
    SUM(COALESCE(source.installs, 0)) AS tot_installs,
    SUM(COALESCE(source.impressions, 0)) AS tot_impressions,
    SUM(COALESCE(source.cost, 0)) AS tot_cost,
    SUM(COALESCE(source.value, 0)) AS tot_value
  FROM `project.dataset.external_creative_daily` AS source
  LEFT JOIN `project.dataset.product_dimension` AS product
    ON source.product_id = product.product_id
  WHERE
    source.install_date BETWEEN evaluation_period_start_date AND evaluation_period_end_date
    AND LOWER(source.campaign_name) LIKE "%test_campaign%"
    AND (
      source.asset_type IS NULL
      OR source.asset_type NOT LIKE "%Text%"
    )
  GROUP BY 1, 2, 3, 4
)

SELECT * FROM creative_performance_source_a

UNION ALL

SELECT * FROM creative_performance_source_b;
