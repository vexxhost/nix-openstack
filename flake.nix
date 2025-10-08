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
    nix2container = {
      url = "github:nlewo/nix2container";
      inputs.nixpkgs.follows = "nixpkgs";
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
          {
            system,
            config,
            pkgs,
            ...
          }:
          let
            nix2container = inputs.nix2container.packages.${system}.nix2container;
          in
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

            packages = rec {
              tini-root = pkgs.runCommand "tini-root" { } ''
                	        mkdir -p $out
                                cp -v ${pkgs.tini}/bin/tini $out/tini
              '';

              openvswitchImage = nix2container.buildImage {
                name = "ghcr.io/vexxhost/openvswitch";
                tag = "latest";

                copyToRoot = [
                  (pkgs.buildEnv {
                    name = "tini";
                    paths = [ tini-root ];
                    pathsToLink = [ "/" ];
                  })
                  (pkgs.buildEnv {
                    name = "bin";
                    paths = with pkgs; [
                      jq
                      config.packages.openvswitch
                    ];
                    pathsToLink = [ "/bin" ];
                  })
                ];
              };
            };
          };

        flake = {
          overlays.default =
            final: prev: withSystem prev.stdenv.hostPlatform.system ({ config, ... }: config.packages);
        };
      }
    );
}
