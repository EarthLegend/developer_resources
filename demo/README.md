# Demo Notebooks

A growing collection of runnable notebooks that show what you can build on LGND embeddings.
Each notebook lives in its own numbered folder with a README, a `requirements.txt`, and any data it needs.
More notebooks will be added here over time.

## Available notebooks

| # | Notebook | What it shows | Runs without an API key? |
|---|---|---|---|
| 1 | [API Quickstart](01-api-quickstart/) | A tour of the LGND API: search by text and location, chip thumbnails and metadata, change detection, and creating a collection + index. | No, needs API credentials |
| 2 | [Reading a Landscape](02-reading-a-landscape/) | Forecast next month's embedding, build a crop map, and detect year-over-year change over California farmland, using embeddings alone. | Yes, ships with a cached dataset |

Open any notebook in Google Colab straight from its README:

| # | Notebook | Colab |
|---|---|---|
| 1 | API Quickstart | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/EarthLegend/developer_resources/blob/main/demo/01-api-quickstart/LGND_API_Demo.ipynb) |
| 2 | Reading a Landscape | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/EarthLegend/developer_resources/blob/main/demo/02-reading-a-landscape/reading-a-landscape.ipynb) |

## Running locally

Each notebook folder is self-contained.
Install its dependencies, then launch it:

```bash
cd 01-api-quickstart          # or any notebook folder
pip install -r requirements.txt
jupyter notebook
```

Notebooks that call the LGND API read credentials from environment variables.
Copy the template at the repo root and fill in your keys:

```bash
cp ../.env.example .env
```

See each notebook's own README for the variables it needs and whether it can run entirely from a bundled cache.
