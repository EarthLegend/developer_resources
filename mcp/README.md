# LGND MCP Server — User Guide

Connect Claude (and other AI assistants) directly to LGND's geospatial embeddings
search. Ask questions in plain language — *"find swimming pools in this collection"*,
*"show me what changed near this coordinate between 2020 and 2022"* — and the
assistant calls LGND's search tools and returns georeferenced results.

This server speaks the [Model Context Protocol (MCP)](https://modelcontextprotocol.io),
an open standard for connecting AI assistants to external tools. Any MCP-compatible
client can use it.

---

## What you can do

The server exposes LGND's embeddings search as a set of tools the assistant calls on
your behalf — you don't call them directly; the assistant picks the right one from your
request. First, two core concepts:

- **Tenant** — your account on LGND. Most users have exactly one.
- **Collection** — a scoped dataset of satellite or aerial imagery *chips* (image
  tiles) within a tenant that can be searched by visual similarity. Collections differ
  by model (e.g. Clay v1.5 + NAIP for high-resolution US aerial), geographic coverage,
  and date range.

The available tools:

| Tool | What it does |
| --- | --- |
| `list_tenants` | List the tenants (accounts) your key can access. |
| `get_tenant` | Get details for one tenant. |
| `list_collections` | List the collections in a tenant. |
| `get_collection` | Get details for one collection (model, coverage, dates). |
| `search_by_text` | Find chips matching a natural-language query (*"solar farms"*). |
| `search_by_location` | Find chips visually similar to a lat/lon point. |
| `search_by_chip` | Find chips visually similar to a reference chip. |
| `search_changed_chips` | Find chips whose imagery changed between two time periods. Needs a collection with multi-year coverage. |
| `list_chips_by_cell` | List chips within a spatial grid cell. |
| `filter_by_geometry` | Narrow results to a GeoJSON area of interest. |
| `classify_chips` | Classify a set of chips. |
| `describe_change_by_chip_pairs` | Describe what changed between pairs of chips. |
| `get_chip_metadata` | Full metadata for a chip. |
| `get_chip_thumbnail_url` | A displayable imagery thumbnail URL for a chip. |

A typical session: the assistant lists your tenants → lists collections → runs a search
→ returns chips. Each result includes a `chip_id`, a similarity `score`, GeoJSON
`geometry`, a `centroid`, and a `datetime` — enough to map results or fetch imagery.

---

## Prerequisites

1. **An LGND account** with access to the embeddings API.
2. **MCP access enabled** on your account (the `allow_mcp_server` entitlement). If your
   account doesn't have it yet, email [sales@lgnd.ai](mailto:sales@lgnd.ai)
   or your account admin.
3. For command-line / IDE clients (Claude Code, Cursor): an **LGND API key**
   (`sk_live_…`), created in the [developer portal](https://developer.lgnd.ai).
   Web (claude.ai) clients don't need an API key — they sign in via your browser.

---

## Endpoint

The LGND MCP server is available at:

```
https://earth.lgnd.ai/mcp
```

---

## Connecting

### Option A — Claude.ai (web), via OAuth

The easiest path. No API key needed; you sign in through your browser.

1. In Claude, go to **Settings → Connectors → Add custom connector**.
2. **Name:** `LGND` (anything you like).
3. **Remote MCP server URL:** `https://earth.lgnd.ai/mcp`
4. Leave **OAuth Client ID** and **Client Secret** blank — the server registers Claude
   automatically.
5. Click **Add**, then **Connect**. You'll be redirected to LGND's sign-in page,
   where you authorize access. Once authorized, the LGND tools appear in your chat.

Now just ask: *"Using the LGND connector, find 5 swimming pools in my collection."*

### Option B — Claude Code (CLI)

Claude Code runs the connection over your API key:

```bash
claude mcp add --transport http lgnd \
  https://earth.lgnd.ai/mcp \
  --header "Authorization: Bearer sk_live_<your-key>"
```

Then, in a Claude Code session, ask it to use the LGND tools.

### Option C — Cursor / Claude Desktop / other MCP clients

Most desktop MCP clients accept a remote (Streamable-HTTP) server with a bearer header.
Add an entry like this to your client's MCP config (e.g. Cursor's `mcp.json` or Claude
Desktop's `claude_desktop_config.json`):

```json
{
  "mcpServers": {
    "lgnd": {
      "url": "https://earth.lgnd.ai/mcp",
      "headers": {
        "Authorization": "Bearer sk_live_<your-key>"
      }
    }
  }
}
```

Restart the client and the LGND tools will be available.

---

## Example prompts

Once connected, talk to the assistant naturally. It handles tenant/collection selection
and tool sequencing for you.

- *"Find 10 swimming pools in the LA NAIP collection and show me thumbnails."*
- *"Find visually similar imagery to 34.045, -118.259"*
- *"Which of my collections covers Los Angeles, and what years does it span?"*
- *"What changed in that collection between 2020 and 2022?"*
- *"Find solar farms, but only within this GeoJSON boundary: {…}"*
- *"Get the full metadata for chip <chip_id>."*


---

## Troubleshooting

**The connector won't authorize / sign-in fails.**
Make sure you're signing in with an LGND account that has API access. If you reach the
LGND sign-in page but authorization fails afterward, your account may be missing MCP
access — see the next item.

**Tools appear but every call fails with "access denied" (403).**
Your credential is valid but your account lacks the MCP entitlement
(`allow_mcp_server`). Email [sales@lgnd.ai](mailto:sales@lgnd.ai) or your
account admin to enable it.

**"Invalid token" / 401 on a CLI or IDE client.**
Your API key is missing, expired, or malformed. Confirm the `Authorization: Bearer
sk_live_…` header is set correctly, and regenerate the key in the
[developer portal](https://developer.lgnd.ai) if needed.

**Searches return nothing or the wrong area.**
Ask the assistant to confirm which collection it's using — a collection only covers a
specific geography, date range, and imagery source. `get_collection` shows its coverage.

---

## Support

Questions, access requests, or bugs: email
[sales@lgnd.ai](mailto:sales@lgnd.ai) or your account representative.
