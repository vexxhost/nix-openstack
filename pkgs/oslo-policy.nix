{ buildPythonPackage
, fetchFromGitea

, pbr

, oslo-config
, oslo-context
, oslo-i18n
, oslo-serialization
, oslo-utils
, pyyaml
, requests
, stevedore

, oslotest
, requests-mock
, sphinx
, stestr
}:

buildPythonPackage rec {
  pname = "oslo-policy";
  version = "4.2.1";

  # Manually set version because prb wants to get it from the git
  # upstream repository (and we are installing from tarball instead)
  PBR_VERSION = version;

  src = fetchFromGitea {
    domain = "opendev.org";
    owner = "openstack";
    repo = "oslo.policy";
    rev = version;
    sha256 = "sha256-UvT8GJ+uEYsYwHR+p8OpKQjuqkFKHNg3DqU9wILVY14=";
  };

  nativeBuildInputs = [
    pbr
  ];

  propagatedBuildInputs = [
    oslo-config
    oslo-context
    oslo-i18n
    oslo-serialization
    oslo-utils
    pyyaml
    requests
    stevedore
  ];

  nativeCheckInputs = [
    oslotest
    requests-mock
    sphinx
    stestr
  ];

  checkPhase = ''
    stestr run
  '';

  pythonImportsCheck = [ "oslo_policy" ];
}
