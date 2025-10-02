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
    pkgs-by-name = {
      url = "github:drupol/pkgs-by-name-for-flake-parts";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { withSystem, ... }:
      {
        systems = import inputs.systems;

        imports = [
          inputs.treefmt-nix.flakeModule
          inputs.pkgs-by-name.flakeModule
        ];

        perSystem =
          { system, config, ... }:
          {
            _module.args.pkgs = import inputs.nixpkgs {
              inherit system;
              overlays = [
                (final: prev: {
                  local = config.packages;
                })
              ];
            };

            pkgsDirectory = ./pkgs/by-name;

            treefmt = {
              projectRootFile = "flake.nix";
              programs.nixfmt.enable = true;
            };
          };

        flake = {
          overlays.default =
            final: prev: withSystem prev.stdenv.hostPlatform.system ({ config, ... }: config.packages);
        };
      }
    );
}
