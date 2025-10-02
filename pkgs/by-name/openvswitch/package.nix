{
  stdenv,
  lib,
  pkgs,
  fetchFromGitHub,
}:

(pkgs.openvswitch.override {
  dpdk = pkgs.local.dpdk;
  withDPDK = true;
}).overrideAttrs
  (oldAttrs: rec {
    version = "3.3.6";

    src = fetchFromGitHub {
      owner = "openvswitch";
      repo = "ovs";
      tag = "v${version}";
      hash = "sha256-78O2ag56PzdfUDzpVzF36ZcaShHJsrVs5TCyWjR8pRU=";
    };

    patches = oldAttrs.patches ++ [
      ./patches/increase-max-recirc-depth.patch
    ];

    env = {
      CFLAGS = "-O2 ${lib.optionalString stdenv.hostPlatform.isx86_64 "-march=x86-64-v2"}";
    };

    configureFlags = oldAttrs.configureFlags ++ [
      "--with-dbdir=/etc/openvswitch"
    ];
  })
