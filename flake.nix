{
  description = "OpenStack";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }:

    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
          python = pkgs.python310.override {
            packageOverrides = (import ./overlays/python.nix);
          };
        in
        {
          packages = {
            keystone = python.pkgs.keystone;
            # keystone = pkgs.dockerTools.buildLayeredImage {
            #   name = "keystone";
            #   contents = [ python.pkgs.keystone ];
            # };
          };
        }
      );
}
