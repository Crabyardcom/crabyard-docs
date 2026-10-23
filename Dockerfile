FROM oven/bun:1.4.4 AS bun-runtime

FROM node:24-bookworm-slim AS build
COPY --from=bun-runtime /usr/local/bin/bun /usr/local/bin/bun
WORKDIR /app
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile
COPY . .
RUN bun run build

FROM bun-runtime
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY server.ts .
COPY src/server/ src/server/
EXPOSE 3000
CMD ["bun", "server.ts"]
