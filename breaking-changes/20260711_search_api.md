# 2026/07/11 - Search API Migration Guide

For clients migrating off the deprecated search endpoints.

**Motivation:** the old API mixed text queries and chip-id queries in the
same endpoints (text seeds taking chip examples, a chip endpoint named for
change-by-text). The new API decouples them: each endpoint takes exactly
one seed type — text (`search-by-text`, `search-changes-by-text`) or chips
(`search-by-chips`, `search-changes-by-chip-pairs`).

The old paths still work (marked `deprecated: true` in the OpenAPI schema) and
will be removed once all clients migrate.

All paths are under `/v1/tenants/{tenant_id}/collections/{collection_id}/`.

| Deprecated | Replacement |
|---|---|
| `POST .../search-by-chip` | `POST .../search-by-chips` |
| `POST .../search-changed-chips` | `POST .../search-changes-by-text` |
| `positive_chip_ids` / `negative_chip_ids` on `search-by-text` and `search-by-location` | `POST .../search-by-chips` |

## 1. `search-by-chip` → `search-by-chips`

Two request changes:

- **`chip_id` is gone** — it was just another positive example; move it into
  `positive_chip_ids` (now required, at least one entry).
- **The default ranking changed** to `ranking_model: "linear_svm"`, which
  trains an ephemeral probe given ≥5 positive and ≥5 negative chips. Pass
  `ranking_model: "centroid_difference"` to keep legacy-identical results.

```json
POST .../search-by-chips
{
  "positive_chip_ids": [
    "chip_018d5e5a5c8b7890a1b2c3d4e5f6a7b8",
    "chip_018d5e5a5c8b7890a1b2c3d4e5f6a7b9"
  ],
  "negative_chip_ids": ["chip_018d5e5a5c8b7890a1b2c3d4e5f6a7ba"],
  "ranking_model": "centroid_difference",
  "top_k": 10
}
```

`top_k`, `index_id`, `geometry`, `start_date`, and `end_date` are unchanged.

## 2. `search-changed-chips` → `search-changes-by-text`

A pure rename — request, validation, and response are identical. Notes for
both paths:

- Only one of `before`/`after` is required (`after` alone = "became X", `before` alone = "stopped being X").
- The `*_texts_past` / `*_texts_current` fields are deprecated; use
  `before`/`after`.
- The `*_chip_ids_past` / `*_chip_ids_current` fields are deprecated but still
  honored (`negative_*_past` is accepted but dropped). To seed change
  detection from chips going forward, use
  `POST .../search-changes-by-chip-pairs`, which keeps each past/current pair
  together so the search learns the transition.

## 3. Chip examples on `search-by-text` and `search-by-location`

`positive_chip_ids` / `negative_chip_ids` are deprecated on both but still
blended with the seed embedding. For example-driven search, use
`search-by-chips`.
