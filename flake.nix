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

          # Individual version overlays
          dpdk_23_11 = import ./overlays/dpdk/23_11.nix;
          openvswitch_3_3 = import ./overlays/openvswitch/3_3.nix;

          # OpenStack release-specific overlays (compose specific versions)
          caracal = inputs.nixpkgs.lib.composeManyExtensions [
            (import ./overlays/dpdk/23_11.nix)
            (import ./overlays/openvswitch/3_3.nix)
            # Add more overlays as needed for caracal
          ];

          dalmatian = inputs.nixpkgs.lib.composeManyExtensions [
            (import ./overlays/dpdk/23_11.nix)
            (import ./overlays/openvswitch/3_3.nix)
            # When dalmatian needs different versions, just change the imports:
            # (import ./overlays/dpdk/24_03.nix)
            # (import ./overlays/openvswitch/3_4.nix)
          ];

          # Default points to latest stable release
          default = inputs.nixpkgs.lib.composeManyExtensions [
            (import ./overlays/dpdk/23_11.nix)
            (import ./overlays/openvswitch/3_3.nix)
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
