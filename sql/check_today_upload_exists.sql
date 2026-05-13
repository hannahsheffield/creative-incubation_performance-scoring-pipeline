SELECT
  COUNT(*) AS count_rows
FROM `your-gcp-project-id.analytics_dataset.creative_performance_scores`
WHERE
  calc_date = CURRENT_DATE();
