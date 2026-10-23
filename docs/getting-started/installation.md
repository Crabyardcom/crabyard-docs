---
title: Installation
description: Install Crabyard and its prerequisites.
---

# Installation

## Prerequisites {#prerequisites}

Crabyard generates Tauri v2 apps, so you need the Tauri development toolchain installed:

- **Rust** 1.90+ — [rustup.rs](https://rustup.rs/)
- **Bun** 1.1+ — [bun.sh](https://bun.sh/)
- **Git** — [git-scm.com](https://git-scm.com/)

### Platform-specific {#platform-specific}

**Windows:** WebView2 (included in Windows 10 1803+ and Windows 11)

**Linux:**
```sh
# Ubuntu / Debian
sudo apt install libwebkit2gtk-4.1-dev libjavascriptcoregtk-4.1-dev libgtk-3-dev libsoup-3.0-dev libssl-dev libayatana-appindicator3-dev

# Fedora
sudo dnf install webkit2gtk4.1-devel javascriptcoregtk4.1-devel gtk3-devel libsoup3-devel openssl-devel libappindicator-gtk3-devel

# Arch
sudo pacman -S webkit2gtk-4.1 gtk3 libsoup3 openssl libayatana-appindicator
```

**macOS:** Xcode Command Line Tools
```sh
xcode-select --install
```

## Install Crabyard {#install-crabyard}

**macOS / Linux:**

```sh
curl -fsSL https://crabyard.com/install.sh | sh
```

**Windows (PowerShell):**

```powershell
irm https://crabyard.com/install.ps1 | iex
```

The public installer uses a fixed Crabyard Railway endpoint if the custom API domain is unavailable, and reports that choice. The setup scripts pass the selected API origin to their CLI wizard for that run. The CLI itself never silently sends a license key to a different server.

If the custom domain cannot be reached, use the published Railway installer and select the API origin explicitly in your current shell:

```sh
export CRABYARD_API_URL=https://crabyard-api-production.up.railway.app
curl -fsSL https://crabyard-web-production.up.railway.app/install.sh | sh
```

```powershell
$env:CRABYARD_API_URL="https://crabyard-api-production.up.railway.app"
irm https://crabyard-web-production.up.railway.app/install.ps1 | iex
```

`CRABYARD_API_URL` must be an HTTPS origin without credentials, path, query, or fragment. Remove the override when you want to return to the canonical `https://api.crabyard.com` endpoint.

**From source:**

```sh
git clone https://github.com/Crabyardcom/crabyard-cli
cd crabyard-cli
cargo install --path .
```

## Verify installation {#verify-installation}

```sh
crabyard doctor
```

This checks all prerequisites: Rust, Cargo, Bun, Git, Tauri CLI, and platform-specific dependencies.

## License key {#license-key}

Hosted license checkout is not available yet. You can use the public templates without a license key:

```sh
git clone https://github.com/Crabyardcom/crabyard-templates.git
crabyard new "My App" --template ./crabyard-templates --preset local-first --yes
```

Existing license holders can continue to use hosted template downloads. Set your existing key:

```sh
export CRABYARD_LICENSE_KEY=CRAB-...
```

Or pass it directly when generating:

```sh
crabyard new "My App" --license-key CRAB-...
```

Existing `TK-` license keys remain valid. Local generation with `--template /path/to/crabyard-templates` uses the checked-out templates directly.
