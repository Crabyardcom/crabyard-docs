---
title: Quick Start
description: Generate and run your first Crabyard app.
---

# Quick Start

## Generate a project {#generate-a-project}

Run `crabyard new` to create a new app:

```sh
crabyard new "My Desktop App"
```

Interactive generation lets you choose:

1. **Package manager** — Bun, pnpm, Yarn, or npm
2. **Auth provider** — GitHub, Google, or None
3. **UI framework** — shadcn/ui, daisyUI, or Minimal
4. **Extras** — optional plugins and frontend libraries
5. **App details** — name, identifier, version, and metadata

To skip prompts, pass flags directly:

```sh
crabyard new "My Desktop App" --auth github --ui shadcn --yes
```

For a local-first starting point and a focused AI brief:

```sh
crabyard new "Field Notes" --preset local-first --brief "A local-first research notebook with tags and Markdown export" --yes
crabyard check --project ./field-notes
crabyard context --project ./field-notes --brief "Add tags and search" --output docs/TAGS_CONTEXT.md
```

`check` reports configuration gaps without changing files. `context` writes a curated agent handoff that excludes environment values and preserves an existing output file. The generation brief is saved in `docs/AI_CONTEXT.md`. See [AI development](../guides/ai-development.md) for JSON audits, strict CI checks, and context previews.

To use public templates from a local checkout without a license key:

```sh
git clone https://github.com/Crabyardcom/crabyard-templates.git
crabyard new "My Desktop App" --template ./crabyard-templates --preset local-first --yes
```

## Run the app {#run-the-app}

```sh
cd my-desktop-app
bun run tauri dev
```

Your app opens with:

- A custom title bar with window controls
- The login screen (if you chose an auth provider)
- A settings dialog
- Auto-update integration, ready to enable after configuring your signed releases

## Project structure {#project-structure}

```
my-desktop-app/
├── src/                  # React frontend
│   ├── App.tsx
│   ├── components/
│   │   ├── DashboardView.tsx
│   │   ├── LoginView.tsx
│   │   ├── TitleBar.tsx
│   │   └── UpdateBanner.tsx
│   ├── hooks/
│   │   ├── useAuth.ts
│   │   ├── useSettings.ts
│   │   └── useUpdater.ts
│   ├── lib/
│   │   ├── tauri.ts
│   │   ├── types.ts
│   │   └── utils.ts
│   └── store/
│       └── appStore.ts
├── src-tauri/            # Rust backend
│   ├── src/
│   │   ├── lib.rs
│   │   ├── main.rs
│   │   ├── auth/
│   │   ├── commands/
│   │   └── models/
│   ├── Cargo.toml
│   └── tauri.conf.json
├── package.json
└── vite.config.ts
```

## Build for production {#build-for-production}

```sh
bun run tauri build
```

This produces platform-specific installers in `src-tauri/target/release/bundle/`.

## Next steps {#next-steps}

- [Configure auth providers](../guides/auth.md)
- [Customize the UI](../guides/ui.md)
- [Set up auto-updates](../guides/auto-updates.md)
