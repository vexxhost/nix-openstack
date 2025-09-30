# SPDX-FileCopyrightText: © 2025 VEXXHOST, Inc.
# SPDX-License-Identifier: Apache-2.0

final: prev: {
  # Dalmatian also uses OVS 3.3 for now, but can easily switch
  dpdk = final.dpdk_23_11;
  openvswitch = final.openvswitch_3_3;

  # When Dalmatian needs a newer version, just change the reference:
  # openvswitch = final.openvswitch_3_4;

  # Add OpenStack Dalmatian-specific packages here
  # nova = prev.callPackage ./dalmatian/nova.nix { };
  # neutron = prev.callPackage ./dalmatian/neutron.nix { };
}