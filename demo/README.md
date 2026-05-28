# Demo Notebook

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/EarthLegend/developer_resources/blob/main/demo/LGND_API_Demo.ipynb)

Search satellite imagery by text, visualize results on a map, and inspect chip metadata.

## Quickstart

```bash
pip install -r requirements.txt
cp ../.env.example .env   # then fill in your credentials
jupyter notebook LGND_API_Demo.ipynb
```

Or click the **Open in Colab** badge above to run in your browser.

## Environment variables

| Variable | Description |
|---|---|
| `LGND_API_KEY` | Your LGND API key (`sk_...`) |
| `LGND_TENANT_ID` | Your tenant ID (`ten_...`) |
| `LGND_COLLECTION_ID` | The collection to search (`col_...`) |
