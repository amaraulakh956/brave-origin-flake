{
  description = "Brave Origin Nightly browser for NixOS";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.brave-origin-nightly =
      nixpkgs.legacyPackages.x86_64-linux.callPackage ./pkgs/brave-origin-nightly.nix {};
    packages.x86_64-linux.default =
      self.packages.x86_64-linux.brave-origin-nightly;
  };
}
