{
  lib,
  pkgs,
  fetchurl,
}:

pkgs.dpdk.overrideAttrs (oldAttrs: rec {
  version = "23.11.5";
  src = fetchurl {
    url = "https://fast.dpdk.org/rel/dpdk-${version}.tar.xz";
    sha256 = "sha256-ij3/a0O7xYR1IPEFyRaziZhvmTuh6mLnsHpnXFQw4Ww=";
  };
})
