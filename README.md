# Crabyard Documentation

The [Crabyard documentation](https://docs.crabyard.com), built with [Zensical](https://zensical.org/). Standalone repository: [Crabyardcom/crabyard-docs](https://github.com/Crabyardcom/crabyard-docs).

Use Python 3.13, [uv](https://docs.astral.sh/uv/getting-started/installation/), and Bun 1.3.8 or newer. Zensical is pinned in `pyproject.toml`; `uv.lock` fixes its complete dependency graph. Bun serves the built site and runs the server tests without JavaScript dependencies.

```sh
uv sync --locked --no-dev
bun run dev
```

The development preview runs at `http://localhost:4321`. Edit Markdown pages in `docs/`. Navigation, Markdown extensions, theme options, and canonical metadata live in `zensical.toml`. All existing guide URLs are retained, including troubleshooting, splash screen, overlay architecture, and onboarding. Branding assets and styles live in `docs/assets` and `docs/stylesheets`.

```sh
bun test
bun run build
bun run start
docker build -t crabyard-docs .
```

`bun run build` uses strict Zensical validation and writes to `dist/`. `bun run preview` and `bun run start` serve that output on Railway's `PORT` or port 3000. The static server supports GET and HEAD, returns real 404 responses, and confines requests to `dist/`.

The Docker builder installs the locked Python dependencies, builds the static site, and copies only `dist/` and the Bun server into the runtime image. Use this repository's root as the build context and `/` for the health check. Python and the documentation sources are not required at runtime.

The canonical URL is `https://docs.crabyard.com/`. Generated navigation, assets, and search use relative URLs so the built site also works on the Railway-provided domain and local preview. Instant navigation is not enabled because it depends on the canonical sitemap origin.

To update Zensical, change its exact version in `pyproject.toml`, run `uv lock` and `uv sync --locked --no-dev`, then repeat the tests, strict build, and Docker build. Commit the dependency declaration and lockfile together.

The generator lives in [crabyard-cli](https://github.com/Crabyardcom/crabyard-cli); its source templates live in [crabyard-templates](https://github.com/Crabyardcom/crabyard-templates). Keep command examples and generated file descriptions aligned with those repositories.
