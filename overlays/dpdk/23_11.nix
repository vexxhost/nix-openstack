# SPDX-FileCopyrightText: © 2025 VEXXHOST, Inc.
# SPDX-License-Identifier: Apache-2.0

final: prev: {
  dpdk = prev.dpdk.overrideAttrs (oldAttrs: rec {
    version = "23.11.5";
    src = prev.fetchurl {
      url = "https://fast.dpdk.org/rel/dpdk-${version}.tar.xz";
      sha256 = "sha256-ij3/a0O7xYR1IPEFyRaziZhvmTuh6mLnsHpnXFQw4Ww=";
    };
  });
}