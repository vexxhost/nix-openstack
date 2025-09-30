# SPDX-FileCopyrightText: © 2025 VEXXHOST, Inc.
# SPDX-License-Identifier: Apache-2.0

final: prev:
let
  packages = import ../base/packages.nix;
  baseOverlay = import ../base final prev;
in
baseOverlay // {
  # Caracal uses the base OVS 3.3 and DPDK 23.11, no overrides needed
  # Add OpenStack Caracal-specific packages here
  # Example:
  # nova-caracal = prev.callPackage ./caracal/nova.nix { };
  # neutron-caracal = prev.callPackage ./caracal/neutron.nix { };
}