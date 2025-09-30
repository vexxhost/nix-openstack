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
          # Base overlay with core packages
          base = import ./overlays/base;

          # OpenStack release-specific overlays
          caracal = import ./overlays/releases/caracal.nix;
          dalmatian = import ./overlays/releases/dalmatian.nix;

          # Default points to latest stable release
          default = import ./overlays/releases/caracal.nix;
        };
      };

      perSystem =
        { system, ... }:
        let
          # Create package sets for each release
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ flake.overlays.base ];
          };
          pkgs.caracal = import inputs.nixpkgs {
            inherit system;
            overlays = [ flake.overlays.caracal ];
          };
          pkgs.dalmatian = import inputs.nixpkgs {
            inherit system;
            overlays = [ flake.overlays.dalmatian ];
          };
        in
        {
          packages = {
            # Base packages (for backward compatibility)
            inherit (pkgs) dpdk openvswitch openvswitch-dpdk;

            # Nested release namespaces
            caracal = {
              inherit (pkgs.caracal) dpdk openvswitch;
              openvswitch-dpdk = pkgs.caracal.openvswitch-dpdk;
            };

            dalmatian = {
              inherit (pkgs.dalmatian) dpdk openvswitch;
              openvswitch-dpdk = pkgs.dalmatian.openvswitch-dpdk;
            };
          };

          treefmt = {
            projectRootFile = "flake.nix";

            programs.nixfmt.enable = true;
          };
        };
    };
}
