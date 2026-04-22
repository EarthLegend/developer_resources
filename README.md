# LGND Developer Resources

Getting Started Guide: [https://lgnd.ai/lgnd-docs (getting started guide)](url)
API Documentation: [https://embeddings.api.lgnd.ai/v1/reference api reference](url)

## Notebooks

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/EarthLegend/developer_resources/blob/main/LGND_API_Demo.ipynb)

Example notebooks showing how to use the [LGND Embeddings API](https://embeddings.api.lgnd.ai) to search satellite imagery by text, visualize results on a map, and inspect chip metadata.

| Notebook | Description |
|---|---|
| [LGND_API_Demo.ipynb](LGND_API_Demo.ipynb) | Search for railyards across California using text queries, plot results on an interactive map, and inspect chip metadata |

## Quickstart

**Prerequisites:** Python 3.9+, a LGND API key, tenant ID, and collection ID.

```bash
pip install -r requirements.txt
cp .env.example .env   # then fill in your credentials
jupyter notebook LGND_API_Demo.ipynb
```

Or click the **Open in Colab** badge above to run in your browser with no local setup — just add your credentials when prompted.

## Environment variables

| Variable | Description |
|---|---|
| `LGND_API_KEY` | Your LGND API key (`sk_...`) |
| `LGND_TENANT_ID` | Your tenant ID (`ten_...`) |
| `LGND_COLLECTION_ID` | The collection to search (`col_...`) |
