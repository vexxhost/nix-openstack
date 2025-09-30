# SPDX-FileCopyrightText: © 2025 VEXXHOST, Inc.
# SPDX-License-Identifier: Apache-2.0

{
  dpdk = {
    "23.11" = {
      version = "23.11.5";
      sha256 = "sha256-ij3/a0O7xYR1IPEFyRaziZhvmTuh6mLnsHpnXFQw4Ww=";
    };
  };

  openvswitch = {
    "3.3" = {
      version = "3.3.6";
      hash = "sha256-78O2ag56PzdfUDzpVzF36ZcaShHJsrVs5TCyWjR8pRU=";
      patches = [ ./patches/increase-max-recirc-depth.patch ];
    };
  };
}