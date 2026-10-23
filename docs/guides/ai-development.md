---
title: AI Handoff & Readiness
description: Give your coding assistant a focused project brief and inspect the setup work that remains.
---

# AI Handoff & Readiness

Crabyard generates an ordinary Rust, Tauri, React, and TypeScript project. Its coding-agent instructions describe that specific scaffold: the selected stack, typed IPC boundary, important files, security constraints, and verification commands.

`AGENTS.md` is the shared instruction contract. Generated entry points make that guidance available to Codex, Claude Code, GitHub Copilot, Cursor, Gemini CLI, and Windsurf. Update the shared contract as your architecture changes.

## Inspect the project before handing it off {#inspect-the-project-before-handing-it-off}

```sh
crabyard check --project ./field-notes
crabyard check --project ./field-notes --json
crabyard check --project ./field-notes --strict
```

`check` is read-only. It reports specific finding IDs and next actions for project identity, missing lockfiles or agent guidance, OAuth configuration, updater and signing setup, and selected capability or secret-ignore hazards.

Errors produce exit code 1. `--strict` also fails on warnings, which makes the report useful as an additional CI gate. The audit inspects configuration; run the generated frontend and Rust verification commands as well.

## Export a focused context document {#export-a-focused-context-document}

```sh
crabyard context --project ./field-notes \
  --brief "A local-first research notebook with tags and Markdown export"
```

The default output is `docs/AI_CONTEXT.md` in the selected project. It combines your brief with the selected stack and features, a relevant file map, readiness blockers, and a first-slice and verification plan. Environment values, credential stores, signing material, and source-file bodies are excluded from the document. The included readiness audit may inspect supported local environment files for configuration hazards.

```sh
crabyard context --project ./field-notes --brief "Add tags and search" --dry-run
crabyard context --project ./field-notes --brief "Add tags and search" --output docs/SEARCH_CONTEXT.md
```

`--dry-run` prints the Markdown without writing. An existing output file is preserved; choose a new path or intentionally review and replace your previous document yourself.

## Build a small slice, then verify it {#build-a-small-slice-then-verify-it}

Give the assistant the generated instructions and context document. Start with one complete user flow, keep native operations behind the typed Rust command boundary, and run the project's checks before expanding the scope.

```sh
cd field-notes
bun run check
cargo test --manifest-path src-tauri/Cargo.toml
```

Use the package manager saved in your recipe. Authentication client IDs, release signing keys, and updater configuration remain product-specific setup decisions; the generated app does not assume those credentials.
