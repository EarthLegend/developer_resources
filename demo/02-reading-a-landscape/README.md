# Reading a Landscape with LGND Embeddings

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/EarthLegend/developer_resources/blob/main/demo/02-reading-a-landscape/reading-a-landscape.ipynb)

LGND turns satellite imagery into **embeddings**: for every place on the map, a compact
list of numbers that captures what it looks like from space. This notebook shows those
numbers are rich enough to forecast, map crops, and detect change across a farming
landscape near Corcoran, California, using nothing but the embeddings.

- **Part A, forecasting.** Predict each field's next-month embedding from its recent
  history, then turn a predicted embedding back into real imagery.
- **Part B, reading the land.** Classify each field's growing-season embedding into a
  crop map, and flag which fields switched crops between years, checked against the USDA
  Cropland Data Layer (CDL).

## Two ways to run it

**1. From the cache (default, nothing to set up).** The notebook ships with a small
prebuilt dataset, so you can run every cell top to bottom with no account or key. Click
the **Open in Colab** badge above (the first cell installs everything and downloads the
data for you), or run it locally:

```bash
pip install -r requirements.txt
jupyter notebook reading-a-landscape.ipynb
```

**2. Live from the API (watch the embeddings arrive).** Set
`FETCH_EMBEDDINGS_FROM_API = True` in the config cell and add your LGND API key. The
forecasting section then pulls its embeddings straight from the LGND API, one
`search-by-vector` call per month with the vector returned inline via
`expand:["embedding"]`. Everything else keeps using the bundled dataset.

On Colab, add your key with the key icon in the sidebar (Secrets) as `LGND_API_KEY`.
Locally, set the `LGND_API_KEY` environment variable or type it when prompted.

## What you will see

- A forecast that beats simple baselines for most of the year, by the widest margin
  where the land is actually changing.
- A crop map built from a single growing season of embeddings that lines up with the
  USDA ground truth.
- Automatic, label-free change detection between two years.

## Environment variables (only for the live API path)

| Variable | Description |
|---|---|
| `LGND_API_KEY` | Your LGND API key |

Live mode reads embeddings from a collection over this area in your tenant. See the
[LGND docs](https://lgnd.ai/lgnd-docs) to create one, or simply leave the toggle off to
run entirely from the cache.

## Data credits

Sentinel-2 imagery: ESA / Copernicus. Cropland Data Layer: USDA National Agricultural
Statistics Service. Embeddings: LGND (Clay v1.5).
