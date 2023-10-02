{ buildPythonPackage
, fetchFromGitea

, pbr

, amqp
, cachetools
, debtcollector
, futurist
, kombu
, oslo-config
, oslo-log
, oslo-metrics
, oslo-middleware
, oslo-serialization
, oslo-service
, oslo-utils
, pyyaml
, stevedore
, webob

, confluent-kafka
, oslotest
, pifpaf
, stestr
, testscenarios
}:

buildPythonPackage rec {
  pname = "oslo-messaging";
  version = "14.4.1";
  format = "pyproject";

  # Manually set version because prb wants to get it from the git
  # upstream repository (and we are installing from tarball instead)
  PBR_VERSION = version;

  src = fetchFromGitea {
    domain = "opendev.org";
    owner = "openstack";
    repo = "oslo.messaging";
    rev = version;
    sha256 = "sha256-A7JYj/yHU7c0PIL6WsCcGrq5yejUT/AOhRldk3ga1mw=";
  };

  nativeBuildInputs = [
    pbr
  ];

  propagatedBuildInputs = [
    amqp
    cachetools
    debtcollector
    futurist
    kombu
    oslo-config
    oslo-serialization
    oslo-service
    oslo-utils
    oslo-config
    oslo-log
    oslo-metrics
    oslo-middleware
    oslo-serialization
    oslo-service
    oslo-utils
    pyyaml
    stevedore
    webob
  ];

  nativeCheckInputs = [
    confluent-kafka
    oslotest
    pifpaf
    stestr
    testscenarios
  ];

  checkPhase = ''
    stestr run
  '';

  pythonImportsCheck = [ "oslo_messaging" ];
}
