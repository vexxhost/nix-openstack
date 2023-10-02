{ buildPythonPackage
, fetchFromGitea

, pbr

, oslo-config
, oslo-log
, oslo-utils
, prometheus-client

, oslotest
, stestr
}:

buildPythonPackage rec {
  pname = "oslo-metrics";
  version = "0.7.0";
  format = "pyproject";

  # Manually set version because prb wants to get it from the git
  # upstream repository (and we are installing from tarball instead)
  PBR_VERSION = version;

  src = fetchFromGitea {
    domain = "opendev.org";
    owner = "openstack";
    repo = "oslo.metrics";
    rev = version;
    sha256 = "sha256-yHc2566/tTQggcdokFBN/Ed4CYEt7krgEHCgUMSZqm8=";
  };

  nativeBuildInputs = [
    pbr
  ];

  propagatedBuildInputs = [
    oslo-config
    oslo-log
    oslo-utils
    prometheus-client
  ];

  nativeCheckInputs = [
    oslotest
    stestr
  ];

  checkPhase = ''
    stestr run
  '';

  pythonImportsCheck = [ "oslo_metrics" ];
}
