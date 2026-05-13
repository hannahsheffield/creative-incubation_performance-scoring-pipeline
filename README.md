<a name="readme-top"></a>

<div align="center">

  <h1 align="center">Creative Performance Scoring Pipeline</h1>

  <p align="center">
    <strong>An anonymised Python and BigQuery pipeline for ranking marketing creatives using a weighted performance score.</strong>
  </p>

  <p>
    <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white" />
    <img src="https://img.shields.io/badge/Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white" />
    <img src="https://img.shields.io/badge/BigQuery-669DF6?style=for-the-badge&logo=googlecloud&logoColor=white" />
    <img src="https://img.shields.io/badge/SQL-336791?style=for-the-badge&logo=postgresql&logoColor=white" />
  </p>

</div>

---

## Overview

Creative Performance Scoring Pipeline is an anonymised analytics engineering project that calculates a weighted performance score for marketing creatives running in long-lived test campaigns.

The goal of the project is to help marketing and creative teams understand which assets are performing best across campaign environments by combining multiple performance signals into a single, interpretable score.

The pipeline extracts campaign-level creative performance data, calculates score components, applies minimum volume thresholds, prevents duplicate daily uploads, and publishes the final dataset for dashboard reporting.

> This is a portfolio-safe version of a workplace analytics project. It uses generic names, placeholder table references, mock examples, and simplified business logic. No proprietary data, internal URLs, credentials, or confidential company logic are included.

---

## Problem

Creative testing can be difficult when assets are evaluated across ongoing campaign environments rather than isolated experiments.

Common challenges include:

<ul>
  <li>Creatives may have different amounts of exposure</li>
  <li>Newer creatives may not have had enough time to gather performance data</li>
  <li>Some creatives may drive volume but not value</li>
  <li>Manual comparisons across campaigns and networks are time-consuming</li>
  <li>Stakeholders need a clear ranking that can be refreshed regularly</li>
</ul>

Without a structured scoring approach, creative performance reviews can become inconsistent, manual, and difficult to scale.

---

## Solution

This project creates a repeatable scoring workflow that:

<ol>
  <li>Extracts creative-level campaign performance data from BigQuery</li>
  <li>Standardises fields across multiple data sources</li>
  <li>Calculates performance components for each creative</li>
  <li>Combines components into a weighted Creative Fitness Score</li>
  <li>Applies minimum install thresholds by network</li>
  <li>Adds a calculation date for reporting history</li>
  <li>Checks whether the current day has already been uploaded</li>
  <li>Uploads new scored results to a reporting table</li>
</ol>

---

## Scoring Methodology

Each creative receives a weighted score based on three components:

<table>
  <tr>
    <th>Component</th>
    <th>Description</th>
    <th>Example Weight</th>
  </tr>
  <tr>
    <td><strong>Volume Score</strong></td>
    <td>Measures the creative's share of impressions and installs within its campaign.</td>
    <td>50%</td>
  </tr>
  <tr>
    <td><strong>Experience Score</strong></td>
    <td>Measures how long the creative has been active compared with the oldest creative in the campaign.</td>
    <td>30%</td>
  </tr>
  <tr>
    <td><strong>Value Score</strong></td>
    <td>Measures the creative's share of value generated within its campaign.</td>
    <td>20%</td>
  </tr>
</table>

The final score is calculated as:

```text
Creative Fitness Score =
  (Volume Score × Volume Weight)
+ (Experience Score × Experience Weight)
+ (Value Score × Value Weight)
