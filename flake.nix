{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    systems = {
      url = "github:nix-systems/default-linux";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } rec {
      systems = import inputs.systems;

      imports = [
        inputs.treefmt-nix.flakeModule
      ];

      flake = {
        overlays = {
          # Base overlay with all versioned packages
          base = import ./overlays/base;

          # OpenStack release-specific overlays (compose base + release)
          caracal = inputs.nixpkgs.lib.composeManyExtensions [
            (import ./overlays/base)
            (import ./overlays/releases/caracal.nix)
          ];
          dalmatian = inputs.nixpkgs.lib.composeManyExtensions [
            (import ./overlays/base)
            (import ./overlays/releases/dalmatian.nix)
          ];

          # Default points to latest stable release
          default = inputs.nixpkgs.lib.composeManyExtensions [
            (import ./overlays/base)
            (import ./overlays/releases/caracal.nix)
          ];
        };
      };

      perSystem =
        { system, ... }:
        {
          # Expose only overlays, no packages
          # Users should apply overlays to their nixpkgs instance

          treefmt = {
            projectRootFile = "flake.nix";

            programs.nixfmt.enable = true;
          };
        };
    };
}
