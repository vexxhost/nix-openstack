# SPDX-FileCopyrightText: © 2025 VEXXHOST, Inc.
# SPDX-License-Identifier: Apache-2.0

final: prev:
let
  packages = import ../base/packages.nix;
  baseOverlay = import ../base final prev;
in
baseOverlay // {
  # Dalmatian might need a different OVS version
  # Uncomment and modify if needed:
  # openvswitch = prev.openvswitch.overrideAttrs (oldAttrs: rec {
  #   version = "3.4.0";
  #   src = prev.fetchFromGitHub {
  #     owner = "openvswitch";
  #     repo = "ovs";
  #     tag = "v${version}";
  #     hash = "sha256-...";
  #   };
  # });

  # Add OpenStack Dalmatian-specific packages here
  # Example:
  # nova-dalmatian = prev.callPackage ./dalmatian/nova.nix { };
  # neutron-dalmatian = prev.callPackage ./dalmatian/neutron.nix { };
}