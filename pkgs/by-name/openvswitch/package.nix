{
  lib,
  pkgs,
  fetchFromGitHub,
}:

(pkgs.openvswitch.override {
  withDPDK = true;
  dpdk = pkgs.local.dpdk;
}).overrideAttrs
  (oldAttrs: rec {
    version = "3.3.6";
    src = fetchFromGitHub {
      owner = "openvswitch";
      repo = "ovs";
      tag = "v${version}";
      hash = "sha256-78O2ag56PzdfUDzpVzF36ZcaShHJsrVs5TCyWjR8pRU=";
    };
  })
