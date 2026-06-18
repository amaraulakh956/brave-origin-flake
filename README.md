# brave-origin-flake

Nix flake for [Brave Origin Nightly](https://brave.com/origin/) browser on NixOS.

> Brave Origin is free for Linux users.

## Usage

Add to your `flake.nix` inputs:
```nix
inputs = {
  brave-origin.url = "github:amaraulakh956/brave-origin-flake";
};
```

Add `brave-origin` to your outputs args:
```nix
outputs = { self, nixpkgs, brave-origin, ... } @ inputs:
```

Add to your `home.nix` packages:
```nix
home.packages = [
  inputs.brave-origin.packages.x86_64-linux.brave-origin-nightly
];
```

Make sure `inputs` is passed through `extraSpecialArgs` in your `configuration.nix`:
```nix
home-manager = {
  extraSpecialArgs = { inherit inputs; };
  users.YOUR_USERNAME = import ./home.nix;
};
```

And accept it in `home.nix`:
```nix
{ config, pkgs, inputs, ... }:
```

## Auto-updates

This flake is automatically updated daily via GitHub Actions whenever a new Brave Origin Nightly release is available.

## Platforms

- `x86_64-linux`
