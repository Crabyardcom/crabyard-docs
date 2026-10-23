---
title: Onboarding Tour
description: Show a guided welcome tour on first launch.
---

# Onboarding Tour

Crabyard includes a built-in onboarding tour that appears the first time a user opens your app. After completing or dismissing it, it won't show again.

## How it works {#how-it-works}

The `OnboardingTour` component uses `tauri-plugin-store` to persist a flag indicating whether the tour has been completed. On first launch, a multi-step dialog walks the user through the app.

## Customizing steps {#customizing-steps}

Edit the `defaultSteps` array in `src/components/OnboardingTour.tsx`:

```tsx
const defaultSteps: Step[] = [
  {
    title: "Welcome 👋",
    description: "Your custom welcome message here.",
  },
  {
    title: "Feature highlight",
    description: "Explain a key feature of your app.",
  },
];
```

You can also pass custom steps via props:

```tsx
<OnboardingTour steps={myCustomSteps} />
```

## Resetting the tour {#resetting-the-tour}

To show the tour again during development, clear the store:

```tsx
import { load } from "@tauri-apps/plugin-store";

const store = await load("app-state.json", { autoSave: true, defaults: {} });
await store.delete("onboarding_completed");
```

## Disabling {#disabling}

Remove the `<OnboardingTour />` component from `App.tsx`.
