---
title: Introduction
description: What is Crabyard and why use it.
---

# Introduction

Crabyard is a CLI tool that generates [Tauri v2](https://v2.tauri.app/) desktop app foundations. Compose a Rust and React stack with authentication, settings, updater integration, coding-agent instructions, and repeatable project recipes.

## Why Crabyard? {#why-crabyard}

Starting a Tauri project from scratch means:

- Configuring OAuth flows (device flow, PKCE, token refresh)
- Setting up persistent settings with a typed store
- Integrating the Tauri updater plugin with download progress
- Building a custom title bar with window controls
- Choosing and configuring a UI framework
- Wiring all of it together with proper error handling

Crabyard connects these foundations in a generated project. The supported combinations are checked in CI. Your app still needs its own credentials, signing configuration, product behavior, and release review; `crabyard check` identifies configuration gaps before handoff.

## How it works {#how-it-works}

Crabyard uses a **modular overlay system**:

1. A **base template** provides the core Tauri v2 + React + TypeScript scaffold
2. An **auth overlay** adds the authentication provider you choose
3. A **UI overlay** adds the component framework you choose

The CLI copies the base, applies overlays, replaces template tokens (app name, bundle ID, etc.), installs dependencies, and initializes git.

## Stack {#stack}

Every generated app includes:

| Layer | Technology |
|-------|-----------|
| Runtime | Rust + Tauri v2 |
| Frontend | React 19 + TypeScript |
| State | Zustand |
| Persistence | tauri-plugin-store |
| Bundler | Vite |
| Package manager | Bun, npm, pnpm, or Yarn |

## What's next {#whats-next}

- [Install Crabyard](installation.md)
- [Generate your first app](quick-start.md)
