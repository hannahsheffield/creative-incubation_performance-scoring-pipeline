REPORTING_INTERVAL_DAYS = 90

GCP_PROJECT_ID = "your-gcp-project-id"
BQ_DATASET_ID = "analytics_dataset"
BQ_OUTPUT_TABLE = "creative_performance_scores"

VOLUME_WEIGHT = 0.5
EXPERIENCE_WEIGHT = 0.3
VALUE_WEIGHT = 0.2

SOURCE_TABLES = {
    "performance_daily": "project.dataset.performance_daily",
    "creative_dimension": "project.dataset.creative_dimension",
    "product_dimension": "project.dataset.product_dimension",
    "external_creative_daily": "project.dataset.external_creative_daily",
}
