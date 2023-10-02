{ buildPythonPackage
, fetchFromGitea

, pbr

, bcrypt
, debtcollector
, jinja2
, oslo-config
, oslo-context
, oslo-i18n
, oslo-utils
, statsd
, stevedore
, webob

, oslo-serialization
, oslotest
, stestr
}:

buildPythonPackage rec {
  pname = "oslo-middleware";
  version = "5.2.0";
  format = "pyproject";

  # Manually set version because prb wants to get it from the git
  # upstream repository (and we are installing from tarball instead)
  PBR_VERSION = version;

  src = fetchFromGitea {
    domain = "opendev.org";
    owner = "openstack";
    repo = "oslo.middleware";
    rev = version;
    sha256 = "sha256-27kojFIwtymQ+CJDwTf08+UJ99OiH8zguu49bwPeg48=";
  };

  nativeBuildInputs = [
    pbr
  ];

  propagatedBuildInputs = [
    bcrypt
    debtcollector
    jinja2
    oslo-config
    oslo-context
    oslo-i18n
    oslo-utils
    statsd
    stevedore
    webob
  ];

  nativeCheckInputs = [
    oslo-serialization
    oslotest
    stestr
  ];

  checkPhase = ''
    stestr run
  '';

  pythonImportsCheck = [ "oslo_middleware" ];
}
