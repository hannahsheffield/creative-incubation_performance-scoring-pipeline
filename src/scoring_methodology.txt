<a name="readme-top"></a>

<div align="center">

  <h1>Scoring Methodology</h1>

  <p>
    <strong>How the Creative Fitness Score is calculated and interpreted.</strong>
  </p>

</div>

---

## Overview

The <strong>Creative Fitness Score</strong> is designed to rank creatives within campaign environments using a combination of volume, experience, and value signals.

The score is relative to other creatives in the same campaign. This means it is best used for comparing creatives that ran under similar campaign conditions.

---

## Components

<table>
  <tr>
    <th>Component</th>
    <th>What It Measures</th>
    <th>Why It Matters</th>
  </tr>
  <tr>
    <td><strong>Volume Score</strong></td>
    <td>Share of campaign impressions and installs captured by a creative.</td>
    <td>Shows whether the creative is getting delivery and driving install volume.</td>
  </tr>
  <tr>
    <td><strong>Experience Score</strong></td>
    <td>How long the creative has been active compared with the oldest creative in the campaign.</td>
    <td>Helps avoid over-ranking creatives that have not had enough time to gather meaningful data.</td>
  </tr>
  <tr>
    <td><strong>Value Score</strong></td>
    <td>The creative's share of total campaign value.</td>
    <td>Shows whether the creative is contributing meaningful business value, not just volume.</td>
  </tr>
</table>

---

## Volume Score

Volume score measures how much delivery and install volume a creative captured within its campaign.

It is calculated as the average of:

<ul>
  <li>Share of campaign impressions</li>
  <li>Share of campaign installs</li>
</ul>

Both values are multiplied by <code>10</code> to make the score easier to interpret.

---

## Experience Score

Experience score measures how long a creative has been active compared with the oldest creative in the same campaign.

This helps avoid over-ranking creatives that have not had enough time to gather meaningful performance data.

---

## Value Score

Value score measures the creative's share of total campaign value.

In this anonymised version, value is represented as a generic performance value field.

---

## Final Score

The final Creative Fitness Score is calculated using a weighted formula:

```text
Creative Fitness Score =
  (Volume Score × Volume Weight)
+ (Experience Score × Experience Weight)
+ (Value Score × Value Weight)
