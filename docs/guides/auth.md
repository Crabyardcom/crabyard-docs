---
title: Auth Providers
description: Configure GitHub, Google, or no authentication in your Crabyard app.
---

# Auth Providers

Crabyard supports three auth modules. You choose one during project generation with `--auth <module>`.

## GitHub (Device Flow) {#github-device-flow}

The GitHub module uses the [Device Authorization Flow](https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/authorizing-oauth-apps#device-flow) — users see a code, open a browser to enter it, and the app polls for a token. No redirect server needed.

### Setup {#setup}

1. Create a GitHub OAuth App at [github.com/settings/developers](https://github.com/settings/developers) and enable its device flow
2. Copy the public **Client ID**
3. Add it to your `.env` file:

```txt
GITHUB_CLIENT_ID=your_client_id_here
```

### How it works {#how-it-works}

- `device_flow.rs` — starts the device flow, polls for an access token
- `token_store.rs` — delegates token persistence to the native credential module
- `credentials.rs` — stores credentials through the operating system's credential service
- `validate.rs` — fetches the authenticated GitHub profile when restoring a session
- `useAuth.ts` — React hook exposing authentication state and login/logout actions

For local development, set the public ID in the process environment or the project's `.env`. For packaged releases, set the `GITHUB_CLIENT_ID` repository variable: the generated release workflow embeds only the public client ID at build time. Never put a client secret or access token in a `VITE_` variable.

### Scopes {#scopes}

The default scope is `read:user`. Modify the scope in `src-tauri/src/commands/auth.rs`.

## Google (PKCE Loopback) {#google-pkce-loopback}

The Google module uses [PKCE with a loopback redirect](https://developers.google.com/identity/protocols/oauth2/native-app) — the app opens a browser for consent, spins up a local HTTP server to receive the redirect, and exchanges the code for tokens.

### Setup {#setup-1}

1. Create an OAuth client with application type **Desktop app** in the [Google Cloud Console](https://console.cloud.google.com/apis/credentials)
2. Configure the consent screen and test users as required by your Google project
3. Add the public client ID to your `.env` file:

```txt
GOOGLE_CLIENT_ID=your_client_id_here
```

### How it works {#how-it-works-1}

- `loopback.rs` — starts a local HTTP server, opens the browser, handles the redirect
- `token_store.rs` — delegates token persistence to the native credential module
- `credentials.rs` — stores credentials through the operating system's credential service
- `validate.rs` — validates tokens on app startup
- `useAuth.ts` — React hook exposing authentication state and login/logout actions

The generated flow binds `127.0.0.1` on an available port and uses a `/callback` path with PKCE and state validation. It does not require or embed a desktop client secret. For local development, set `GOOGLE_CLIENT_ID` in the process environment or `.env`; for packaged releases, set the repository variable of the same name so the workflow can embed the public ID.

## None {#none}

The `none` module skips authentication entirely. The app opens directly to the dashboard with no login screen. Useful for apps that don't require user identity.

The generated `App.tsx` renders `<DashboardView />` directly instead of gating on auth state.
