---
title: Settings System
description: Persistent app settings with typed state management.
---

# Settings System

Every generated Crabyard app includes a settings system backed by [tauri-plugin-store](https://v2.tauri.app/plugin/store/) and [Zustand](https://zustand.docs.pmnd.rs/).

## Architecture {#architecture}

```
useSettings() hook
  ↓ reads/writes
Zustand store (appStore.ts)
  ↓ persists via
tauri-plugin-store (src-tauri)
  ↓ saves to
JSON file on disk
```

## Usage in components {#usage-in-components}

```tsx
import { useSettings } from "@/hooks/useSettings";

function MyComponent() {
  const { settings, updateSettings, pickFolder } = useSettings();

  return (
    <div>
      <p>Workspace: {settings.workspaceRoot}</p>
      <button onClick={pickFolder}>Change folder</button>
      <button onClick={() => updateSettings({ theme: "light" })}>
        Light theme
      </button>
    </div>
  );
}
```

## Available methods {#available-methods}

| Method | Description |
|--------|-------------|
| `settings` | Current settings object |
| `settingsLoading` | `true` while settings are being loaded |
| `loadSettings()` | Reload settings from disk |
| `updateSettings(partial)` | Merge partial settings and persist; returns `false` and restores prior state if saving fails |
| `pickFolder()` | Open a native folder picker, save selection |

## Adding new settings {#adding-new-settings}

1. Add the field to `AppSettings` in `src/lib/types.ts`:

```ts
export interface AppSettings {
  workspaceRoot: string | null;
  theme: string | null;
  launchAtStartup: boolean;
  myNewSetting: boolean;
}
```

2. Add a default in the Rust settings model (`src-tauri/src/models/settings.rs`)

3. Use it via `useSettings()`:

```tsx
const { settings, updateSettings } = useSettings();
await updateSettings({ myNewSetting: true });
```

Settings are saved to a JSON file in the app's data directory (platform-specific, managed by Tauri).
