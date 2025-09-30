# SPDX-FileCopyrightText: © 2025 VEXXHOST, Inc.
# SPDX-License-Identifier: Apache-2.0

final: prev: {
  dpdk_23_11 = prev.dpdk.overrideAttrs (oldAttrs: rec {
    version = "23.11.5";
    src = prev.fetchurl {
      url = "https://fast.dpdk.org/rel/dpdk-${version}.tar.xz";
      sha256 = "sha256-ij3/a0O7xYR1IPEFyRaziZhvmTuh6mLnsHpnXFQw4Ww=";
    };
  });

  openvswitch_3_3 = (prev.openvswitch.override {
    withDPDK = true;
  }).overrideAttrs (oldAttrs: rec {
    version = "3.3.6";
    src = prev.fetchFromGitHub {
      owner = "openvswitch";
      repo = "ovs";
      tag = "v${version}";
      hash = "sha256-78O2ag56PzdfUDzpVzF36ZcaShHJsrVs5TCyWjR8pRU=";
    };
    patches = (oldAttrs.patches or []) ++ [
      ./patches/increase-max-recirc-depth.patch
    ];
  });

  # Future versions can be added here
  # openvswitch_3_4 = (prev.openvswitch.override { withDPDK = true; }).overrideAttrs ...
  # dpdk_24_03 = prev.dpdk.overrideAttrs ...
}