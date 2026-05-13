import numpy as np
    df = df.copy()

    df["age"] = (
        df["last_in_campaign_install_date"] -
        df["first_in_campaign_install_date"]
    ).dt.days

    df["oldest_creative_in_campaign_age"] = (
        df.groupby("campaign_name")["age"]
        .transform("max")
    )

    df["experience_score"] = np.where(
        df["oldest_creative_in_campaign_age"] > 0,
        (df["age"] / df["oldest_creative_in_campaign_age"]) * 10,
        0,
    )

    return df


def calculate_value_score(df: pd.DataFrame) -> pd.DataFrame:
    """Calculate each creative's share of campaign value."""

    df = df.copy()

    df["tot_value_campaign"] = (
        df.groupby("campaign_name")["tot_value"]
        .transform("sum")
    )

    df["value_score"] = np.where(
        df["tot_value_campaign"] > 0,
        (df["tot_value"] / df["tot_value_campaign"]) * 10,
        0,
    )

    return df


def calculate_creative_fitness_score(
    df: pd.DataFrame,
    volume_weight: float,
    experience_weight: float,
    value_weight: float,
) -> pd.DataFrame:
    """Combine weighted score components into a final creative fitness score."""

    df = df.copy()

    df["creative_fitness_score"] = (
        (df["volume_score"] * volume_weight) +
        (df["experience_score"] * experience_weight) +
        (df["value_score"] * value_weight)
    )

    return df.round(2)


def apply_install_thresholds(
    df: pd.DataFrame,
    thresholds: dict[str, int],
) -> pd.DataFrame:
    """Flag whether each creative has reached the minimum install threshold."""

    df = df.copy()

    df["threshold_installs"] = df["network"].map(thresholds)

    df["threshold_reached"] = np.where(
        df["tot_installs"] >= df["threshold_installs"],
        True,
        False,
    )

    return df
