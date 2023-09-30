# {
#   description = "A very basic flake";

#   outputs = { self, nixpkgs }: {

#     packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

#     packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

#   };
# }


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
          python = pkgs.python310Packages;
        in
        {
          packages.osprofiler = python.callPackage ./pkgs/osprofiler.nix { };

          packages.keystone = with python; buildPythonApplication rec {
            pname = "keystone";
            version = "22.0.0-0";

            # Manually set version because prb wants to get it from the git
            # upstream repository (and we are installing from tarball instead)
            PBR_VERSION = version;

            src = pkgs.fetchFromGitea {
              domain = "opendev.org";
              owner = "openstack";
              repo = pname;
              rev = "0f6b645ce8ffbca9a33c5ab971a46941e96b8c1c";
              sha256 = "sha256-riHWT8Mdlfi+B2/WxlypjTp8iCbn2p9irKzq/ewB6fs=";
            };

            nativeBuildInputs = [
              pbr
            ];

            propagatedBuildInputs = [
              pytz
            ];
          };
        }
      );
}
