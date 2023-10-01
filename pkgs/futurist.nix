{ buildPythonPackage
, fetchFromGitea

, pbr

, eventlet
, oslotest
, stestr
, testscenarios
}:

buildPythonPackage rec {
  pname = "futurist";
  version = "2.4.1";

  # Manually set version because prb wants to get it from the git
  # upstream repository (and we are installing from tarball instead)
  PBR_VERSION = version;

  src = fetchFromGitea {
    domain = "opendev.org";
    owner = "openstack";
    repo = "futurist";
    rev = version;
    sha256 = "sha256-pU/nZbsIx/vQ+UOuIB8D3OoHs8xiHnFOKp7qa0iNZIw=";
  };

  nativeBuildInputs = [
    pbr
  ];

  nativeCheckInputs = [
    eventlet
    oslotest
    stestr
    testscenarios
  ];

  checkPhase = ''
    stestr run
  '';

  pythonImportsCheck = [ "futurist" ];
}
