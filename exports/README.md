# Data Export

Export your collection's embeddings data as [GeoParquet](https://geoparquet.org/) to your own S3 bucket. Each export is hive-partitioned by geohash, year, and month for efficient spatial and temporal queries. Data is encrypted at rest with a per-account KMS key — your IAM principals get read access through the API, no manual bucket policy editing required.

This is the same data format used by the [LGND Clay Embeddings](https://source.coop/lgnd/clay-embeddings) open dataset on Source Cooperative.

## Requirements

You need a paid LGND plan (Developer, Pro, or Enterprise), a collection in `READY` status, and an AWS IAM role or user ARN.

## Quick start

```bash
export LGND_API_KEY=sk_...
./export_collection.sh <tenant_id> <collection_id>
```

The script creates the export, prints the S3 path, and shows you how to check progress. Before your first export, you'll need to grant your IAM principal read access (see below).

## S3 access

LGND provisions a dedicated S3 bucket (`us-east-2` region) for each paid account, encrypted with a per-account KMS key. To read your exported data, tell the API which IAM principals should have access:

```bash
curl -X PUT -H "Authorization: Bearer $LGND_API_KEY" -H "Content-Type: application/json" \
  -d '{"principal_arns": ["arn:aws:iam::123456789012:role/my-reader"]}' \
  https://embeddings.api.lgnd.ai/v1/exports/destination/principals
```

LGND sets the S3 bucket policy and KMS key policy for you — your role doesn't need any IAM policy on its side. Access propagates within about a minute.

## Schema

Each parquet file contains the following columns:

| Column | Type | Description |
|---|---|---|
| `geometry` | binary (WKB) | Chip footprint polygon in EPSG:4326 |
| `bbox` | struct (xmin, ymin, xmax, ymax) | Bounding box for spatial filtering |
| `chips_id` | string | Unique chip identifier |
| `cell_id` | string | Grid cell the chip belongs to |
| `rasters_id` | string | Source raster identifier |
| `datetime` | timestamp (UTC) | Capture date of the source imagery |
| `collection` | string | Collection name |
| `embedding` | list\<float\> | Clay embedding vector (768-d for Clay v1.5) |
| `size` | decimal | Chip size in pixels |

Files are [GeoParquet 1.1](https://geoparquet.org/) compliant with bounding boxes for spatial filtering and Hilbert-curve sorting for spatial locality.

## Directory layout

```
s3://<bucket>/
  ten_<tenant_id>/
    col_<collection_id>/
      geohash_l3=9q5/
        year=2024/
          month=6/
            data_0.parquet
            data_1.parquet
      geohash_l3=u09/
        year=2024/
          month=7/
            data_0.parquet
```

The `tenant_id` and `collection_id` in the path use the same prefixed IDs as the API responses, so you can navigate directly from an API response to the S3 data.

## Reading the data

```sql
-- duckdb
INSTALL httpfs; LOAD httpfs; INSTALL spatial; LOAD spatial;
SET s3_region = 'us-east-2';

-- Read all partitions
SELECT chips_id, datetime, ST_AsText(geometry) as geom
FROM read_parquet('s3://BUCKET/ten_.../col_.../**/*.parquet', hive_partitioning=true)
LIMIT 10;

-- Filter by partition (fast — only reads matching files)
SELECT *
FROM read_parquet('s3://BUCKET/ten_.../col_.../**/*.parquet', hive_partitioning=true)
WHERE geohash_l3 = '9q5' AND year = 2024;

-- Spatial filter: bbox for row group pruning + ST_Intersects for precision
SELECT chips_id, datetime, ST_AsText(geometry) as geom
FROM read_parquet('s3://BUCKET/ten_.../col_.../**/*.parquet', hive_partitioning=true)
WHERE bbox.xmin >= -118.5 AND bbox.xmax <= -118.1
  AND bbox.ymin >= 33.7  AND bbox.ymax <= 34.1
  AND ST_Intersects(geometry, ST_GeomFromText('POLYGON((-118.5 33.7, -118.1 33.7, -118.1 34.1, -118.5 34.1, -118.5 33.7))'));
```

## API reference

| Endpoint | Method | Description |
|---|---|---|
| `/v1/exports/destination` | GET | Check your bucket name, region, and provisioning status |
| `/v1/exports/destination/principals` | PUT | Set IAM principals that can read your bucket |
| `/v1/tenants/{id}/collections/{id}/exports` | POST | Start an export |
| `/v1/tenants/{id}/collections/{id}/exports/{id}` | GET | Check export status |
