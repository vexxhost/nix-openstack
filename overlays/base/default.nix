# SPDX-FileCopyrightText: © 2025 VEXXHOST, Inc.
# SPDX-License-Identifier: Apache-2.0

final: prev:
let
  packages = import ./packages.nix;
in
{
  dpdk = prev.dpdk.overrideAttrs (oldAttrs: rec {
    inherit (packages.dpdk."23.11") version sha256;
    src = prev.fetchurl {
      url = "https://fast.dpdk.org/rel/dpdk-${version}.tar.xz";
      inherit sha256;
    };
  });

  openvswitch = prev.openvswitch.overrideAttrs (oldAttrs: rec {
    inherit (packages.openvswitch."3.3") version;
    src = prev.fetchFromGitHub {
      owner = "openvswitch";
      repo = "ovs";
      tag = "v${version}";
      inherit (packages.openvswitch."3.3") hash;
    };
    patches = (oldAttrs.patches or []) ++ packages.openvswitch."3.3".patches;
  });

  openvswitch-dpdk = final.openvswitch.override {
    withDPDK = true;
  };
}