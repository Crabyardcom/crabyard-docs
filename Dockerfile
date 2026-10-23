FROM oven/bun:1.4.4 AS bun-runtime

FROM ghcr.io/astral-sh/uv:0.12.0 AS uv-runtime

FROM python:3.13-slim-bookworm AS build
COPY --from=uv-runtime /uv /usr/local/bin/uv
WORKDIR /app
ENV UV_PYTHON_DOWNLOADS=never UV_LINK_MODE=copy
COPY pyproject.toml uv.lock .python-version ./
RUN uv sync --locked --no-dev
COPY zensical.toml ./
COPY docs/ docs/
RUN uv run --locked --no-dev zensical build --strict

FROM bun-runtime
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY server.ts .
COPY src/server/ src/server/
EXPOSE 3000
CMD ["bun", "server.ts"]
