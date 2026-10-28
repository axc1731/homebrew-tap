# axc1731 Homebrew Tap

## Install

```sh
brew tap axc1731/tap
brew install --cask fritax-2025
```

Or install without tapping first:

```sh
brew install axc1731/tap/fritax-2025
```

## Casks

| Cask | Description |
| --- | --- |
| `fritax-2025` | FriTax 2025, tax declaration software of the canton of Fribourg, Switzerland, published by Ringler Informatik AG |

## Notes

- Intel-only app; requires Rosetta 2 on Apple Silicon.
- Installs into `~/FriTax 2025`, where tax files (`dataroot`) are stored.
- `brew uninstall` keeps the tax files. `brew uninstall --zap` deletes them.
- The app updates itself (`auto_updates`).
- This tap is unofficial and is not affiliated with the État de Fribourg or Ringler.
