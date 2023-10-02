{ buildPythonPackage
, fetchFromGitea

, pbr

, debtcollector
, eventlet
, fixtures
, greenlet
, oslo-concurrency
, oslo-config
, oslo-i18n
, oslo-log
, oslo-utils
, paste
, pastedeploy
, routes
, webob
, yappi

, oslotest
, procps
, requests
, stestr
}:

buildPythonPackage rec {
  pname = "oslo-service";
  version = "3.2.0";
  format = "pyproject";

  # Manually set version because prb wants to get it from the git
  # upstream repository (and we are installing from tarball instead)
  PBR_VERSION = version;

  src = fetchFromGitea {
    domain = "opendev.org";
    owner = "openstack";
    repo = "oslo.service";
    rev = version;
    sha256 = "sha256-+zX4wwgosp8nStFQSplMuYmcSPgBWXKiDJB3ajtgo4I=";
  };

  nativeBuildInputs = [
    pbr
  ];

  propagatedBuildInputs = [
    debtcollector
    eventlet
    fixtures
    greenlet
    oslo-concurrency
    oslo-config
    oslo-i18n
    oslo-log
    oslo-utils
    paste
    pastedeploy
    routes
    webob
    yappi
  ];

  nativeCheckInputs = [
    oslotest
    procps
    requests
    stestr
  ];

  checkPhase = ''
    stestr run
  '';

  pythonImportsCheck = [ "oslo_service" ];
}
