# Demo Notebooks

A growing collection of runnable notebooks that show what you can build on LGND embeddings.
Each notebook lives in its own numbered folder with a README, a `requirements.txt`, and any data it needs.
More notebooks will be added here over time.

## Available notebooks

| # | Notebook | What it shows | Runs without an API key? |
|---|---|---|---|
| 1 | [API Quickstart](01-api-quickstart/) | A tour of the LGND API: search by text and location, chip thumbnails and metadata, change detection, and creating a collection + index. | No, needs API credentials |
| 2 | [Reading a Landscape](02-reading-a-landscape/) | Forecast next month's embedding, build a crop map, and detect year-over-year change over California farmland, using embeddings alone. | Yes, ships with a cached dataset |
| 3 | [API Demo — October 2026](03-api-demo-october-2026/) | Search California for burn scars, find farmland that became homes, and have the API describe what changed. Set up for workshops: runs in Colab or locally with just an API key and collection ID from [developer.lgnd.ai](https://developer.lgnd.ai). | No, needs API credentials |
| 4 | [LGND Geo Agent](https://github.com/EarthLegend/carto-sdsc-workshop-2026) | Build a geospatial agent on the LGND Geo MCP server: call its tools from Python, show results on a map, hand the tools to Claude, and finish with a chat panel beside a live map. Built for the CARTO × SDSC workshop; lives in its own repo. | No, needs an LGND sign-in and an Anthropic API key |

Open any notebook in Google Colab straight from its README:

| # | Notebook | Colab |
|---|---|---|
| 1 | API Quickstart | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/EarthLegend/developer_resources/blob/main/demo/01-api-quickstart/LGND_API_Demo.ipynb) |
| 2 | Reading a Landscape | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/EarthLegend/developer_resources/blob/main/demo/02-reading-a-landscape/reading-a-landscape.ipynb) |
| 3 | API Demo — October 2026 | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/EarthLegend/developer_resources/blob/main/demo/03-api-demo-october-2026/LGND_API_Demo_October_2026.ipynb) |
| 4 | LGND Geo Agent | Runs locally only (browser sign-in); see the [repo README](https://github.com/EarthLegend/carto-sdsc-workshop-2026#run-it) |

## Running locally

Each notebook folder is self-contained.
Install its dependencies, then launch it:

```bash
cd 01-api-quickstart          # or any notebook folder
pip install -r requirements.txt
jupyter notebook
```

Notebooks that call the LGND API read credentials from environment variables.
From inside a notebook folder, copy the template at the repo root and fill in your keys:

```bash
cp ../../.env.example .env
```

See each notebook's own README for the variables it needs and whether it can run entirely from a bundled cache.
