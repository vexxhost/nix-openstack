{ buildPythonPackage
, fetchFromGitea

, pbr

, debtcollector
, oslo-config
, oslo-serialization
, pytz
, six

, stestr
}:

buildPythonPackage rec {
  pname = "pycadf";
  version = "3.1.1";

  # Manually set version because prb wants to get it from the git
  # upstream repository (and we are installing from tarball instead)
  PBR_VERSION = version;

  src = fetchFromGitea {
    domain = "opendev.org";
    owner = "openstack";
    repo = pname;
    rev = version;
    sha256 = "sha256-IzZkyMuCBhoknY0pCSeHCkbh8o6NnVRwsdf50Ts6VQA=";
  };

  nativeBuildInputs = [
    pbr
  ];

  propagatedBuildInputs = [
    debtcollector
    oslo-config
    oslo-serialization
    pytz
    six
  ];

  nativeCheckInputs = [
    stestr
  ];

  checkPhase = ''
    stestr run
  '';

  pythonImportsCheck = [ "pycadf" ];
}
