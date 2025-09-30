# SPDX-FileCopyrightText: © 2025 VEXXHOST, Inc.
# SPDX-License-Identifier: Apache-2.0

# OVS 3.3 overlay that depends on DPDK 23.11
final: prev: {
  openvswitch = (prev.openvswitch.override {
    withDPDK = true;
    dpdk = final.dpdk;  # Use the dpdk from our overlay chain
  }).overrideAttrs (oldAttrs: rec {
    version = "3.3.6";
    src = prev.fetchFromGitHub {
      owner = "openvswitch";
      repo = "ovs";
      tag = "v${version}";
      hash = "sha256-78O2ag56PzdfUDzpVzF36ZcaShHJsrVs5TCyWjR8pRU=";
    };
    patches = (oldAttrs.patches or []) ++ [
      ../base/patches/increase-max-recirc-depth.patch
    ];
  });
}