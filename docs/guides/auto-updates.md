---
title: Auto-Updates
description: Built-in auto-update system with download progress and one-click install.
---

# Auto-Updates

Every generated Crabyard app includes [tauri-plugin-updater](https://v2.tauri.app/plugin/updater/) and a floating update banner. Automatic checks and updater artifacts are disabled until you configure your own endpoint, public signing key, and release process.

## How it works {#how-it-works}

1. In a production build with `VITE_UPDATER_ENABLED=true`, `useUpdater()` calls `check()` against the configured update endpoint
2. If a newer version is found, `UpdateBanner` appears in the bottom-right corner
3. User clicks **"Update now"** → the update downloads with a progress bar
4. After download, the app relaunches with the new version

## Configuration {#configuration}

Configure the HTTPS update endpoint and public signing key in `src-tauri/tauri.conf.json`, then enable updater artifacts:

```json
{
  "bundle": {
    "createUpdaterArtifacts": true
  },
  "plugins": {
    "updater": {
      "endpoints": [
        "https://github.com/YOUR_ORG/YOUR_REPO/releases/latest/download/latest.json"
      ],
      "pubkey": "YOUR_PUBLIC_KEY"
    }
  }
}
```

Set `VITE_UPDATER_ENABLED=true` in the production build environment after the endpoint is ready. The generated release workflow sets this flag for its builds and verifies the updater configuration before building.

### Generate signing keys {#generate-signing-keys}

Tauri requires update bundles to be signed:

```sh
bunx tauri signer generate -w ~/.tauri/myapp.key
```

This creates a keypair. Set the environment variable for builds:

```sh
export TAURI_SIGNING_PRIVATE_KEY=$(cat ~/.tauri/myapp.key)
export TAURI_SIGNING_PRIVATE_KEY_PASSWORD=""
```

Put the **public key** in `tauri.conf.json` under `plugins.updater.pubkey`.

### Update artifacts {#update-artifacts}

The scaffold starts with `createUpdaterArtifacts: false`. Set it to `true` for Tauri v2 updater bundles and signatures. A local `tauri build` does not create a GitHub update manifest by itself. The generated release workflow uses `tauri-apps/tauri-action` with `uploadUpdaterJson: true` to upload the installers, signatures, and `latest.json` to a draft GitHub Release.

## Components {#components}

### `useUpdater()` hook {#useupdater-hook}

```ts
const {
  available,     // boolean — update found
  version,       // string | null — new version number
  body,          // string | null — release notes
  downloading,   // boolean — download in progress
  progress,      // number — download percentage (0-100)
  error,         // string | null — error message
  checkForUpdate, // () => Promise<void>
  installUpdate,  // () => Promise<void>
  dismiss,        // () => void — hide the banner
} = useUpdater();
```

### `<UpdateBanner />` {#updatebanner-}

A floating notification that appears when an update is available. Shows:

- Version number
- "Update now" / "Later" buttons
- Download progress bar during installation

The banner is rendered in `App.tsx` and positioned fixed at the bottom-right corner.

## GitHub Releases workflow {#github-releases-workflow}

The generated `.github/workflows/release.yml` is opt-in:

1. Commit the frontend lockfile and `src-tauri/Cargo.lock`, updater configuration, and app version.
2. Configure the signing secrets required for your target platforms and set the repository variable `RELEASE_ENABLED=true`.
3. Create and push a matching version tag, such as `v1.0.1`.
4. Manually run **Signed desktop release** with that existing tag. `scripts/release.mjs` checks version, lockfiles, updater settings, and signing prerequisites.
5. Review the draft release and its assets, then publish it. Running apps with automatic updates enabled can then discover the release.

## Disabling auto-updates {#disabling-auto-updates}

Keep `VITE_UPDATER_ENABLED=false` or unset to disable automatic checks. Keep `createUpdaterArtifacts: false` when you do not need update bundles. You can also remove `<UpdateBanner />` from your layout if you do not want the UI.
