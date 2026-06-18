# brave-origin-flake

Nix flake for Brave Origin Nightly browser on NixOS.

## Usage

Add to your `flake.nix` inputs:
```nix
brave-origin.url = "github:amaraulakh956/brave-origin-flake";
```

Add to your outputs args:
```nix
outputs = { self, nixpkgs, brave-origin, ... } @ inputs:
```

Add to your `home.nix` packages:
```nix
inputs.brave-origin.packages.x86_64-linux.brave-origin-nightly
```

## Auto-updates

This flake is automatically updated daily via GitHub Actions.
