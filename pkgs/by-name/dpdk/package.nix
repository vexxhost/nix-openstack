{
  stdenv,
  pkgs,
  fetchurl,
}:

(pkgs.dpdk.override {
  machine = (
    if stdenv.hostPlatform.isx86_64 then
      "x86-64-v2"
    else if stdenv.hostPlatform.isAarch64 then
      "generic"
    else
      null
  );
}).overrideAttrs
  rec {
    version = "23.11.5";

    src = fetchurl {
      url = "https://fast.dpdk.org/rel/dpdk-${version}.tar.xz";
      sha256 = "sha256-ij3/a0O7xYR1IPEFyRaziZhvmTuh6mLnsHpnXFQw4Ww=";
    };
  }
