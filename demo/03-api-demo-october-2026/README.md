# LGND API Demo — October 2026

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/EarthLegend/developer_resources/blob/main/demo/03-api-demo-october-2026/LGND_API_Demo_October_2026.ipynb)

A walkthrough of the LGND Embeddings API on NAIP aerial imagery of California:

1. **Search by text**: find burn scars with a plain-language query and map them
2. **Chip thumbnails and metadata**: look at the imagery behind each result
3. **Change detection**: search all of California for farmland that became homes
4. **Change description**: have the API explain what changed in plain language

## Get your credentials

1. Create an account at [developer.lgnd.ai](https://developer.lgnd.ai).
2. Create an API key (`sk_...`).
3. Your account comes with an indexed NAIP collection. Find it in the portal and copy its collection ID (`col_...`).

You don't need a tenant ID. The notebook finds it from your collection.

## Run in Colab

Click the **Open in Colab** badge above. In the 🔑 *Secrets* panel in the left sidebar, add
`LGND_API_KEY` and `LGND_COLLECTION_ID` and turn on *Notebook access*. Then run all cells.
If you skip the secrets, the notebook asks you to paste them in.

## Run locally

```bash
pip install -r requirements.txt
cp ../../.env.example .env   # then fill in LGND_API_KEY and LGND_COLLECTION_ID
jupyter notebook LGND_API_Demo_October_2026.ipynb
```

## Environment variables

| Variable | Description |
|---|---|
| `LGND_API_KEY` | Your LGND API key (`sk_...`) |
| `LGND_COLLECTION_ID` | Your NAIP collection ID (`col_...`), from developer.lgnd.ai |
