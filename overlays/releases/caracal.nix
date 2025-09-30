# SPDX-FileCopyrightText: © 2025 VEXXHOST, Inc.
# SPDX-License-Identifier: Apache-2.0

final: prev: {
  # Caracal uses these specific versions
  dpdk = final.dpdk_23_11;
  openvswitch = final.openvswitch_3_3;

  # Add OpenStack Caracal-specific packages here
  # nova = prev.callPackage ./caracal/nova.nix { };
  # neutron = prev.callPackage ./caracal/neutron.nix { };
}