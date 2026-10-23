# Agent instructions

- This standalone repository owns the Zensical documentation and Bun static server.
- Run `uv sync --locked --no-dev`, `bun test`, and `bun run build` after changes. Build with Python 3.13 and the committed `uv.lock`; keep Zensical pinned in `pyproject.toml`.
- Markdown lives in `docs/`; navigation and metadata live in `zensical.toml`. Preserve existing route paths and heading IDs. Keep every published page reachable from navigation.
- Keep the canonical URL `https://docs.crabyard.com/` while preserving relative navigation, assets, and search on the Railway-provided origin. Do not enable canonical-origin-dependent instant navigation without verifying both origins.
- Keep branding in `docs/stylesheets` and `docs/assets`. Prefer Zensical's native search, navigation, tabs, admonitions, and code-copy controls to custom JavaScript.
- Keep CLI examples aligned with `Crabyardcom/crabyard-cli`; generated app examples follow `Crabyardcom/crabyard-templates`.
- Document only implemented behavior. Keep prerequisites, platform limits, and environment variable names explicit.
- Static requests must remain confined to `dist`; preserve GET/HEAD support and real 404 responses.
- The Bun runtime has no JavaScript dependencies. Keep Python tooling and documentation sources out of the production runtime image; verify Docker builds when a daemon is available.
- Add comments only when they explain a non-obvious constraint; keep them under two lines.
