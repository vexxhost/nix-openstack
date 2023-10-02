{ buildPythonPackage
, fetchFromGitea

, pbr

, keystoneauth1
, oslo-cache
, oslo-config
, oslo-context
, oslo-i18n
, oslo-log
, oslo-serialization
, oslo-utils
, pycadf
, pyjwt
, python-keystoneclient
, requests
, webob

, oslo-messaging
, oslotest
, python-memcached
, requests-mock
, stestr
, testresources
, webtest
}:

buildPythonPackage rec {
  pname = "keystonemiddleware";
  version = "10.4.1";
  format = "pyproject";

  # Manually set version because prb wants to get it from the git
  # upstream repository (and we are installing from tarball instead)
  PBR_VERSION = version;

  src = fetchFromGitea {
    domain = "opendev.org";
    owner = "openstack";
    repo = "keystonemiddleware";
    rev = version;
    sha256 = "sha256-rMSnkvYe84tfH6cBr7lRvcFNuAO3F+AORQsePMCUuxM=";
  };

  nativeBuildInputs = [
    pbr
  ];

  propagatedBuildInputs = [
    keystoneauth1
    oslo-cache
    oslo-config
    oslo-context
    oslo-i18n
    oslo-log
    oslo-serialization
    oslo-utils
    pycadf
    pyjwt
    python-keystoneclient
    requests
    webob
  ];

  nativeCheckInputs = [
    # bandit!=1.6.0,>=1.1.0 # Apache-2.0
    # coverage!=4.4,>=4.0 # Apache-2.0
    # cryptography>=3.0 # BSD/Apache-2.0
    # fixtures>=3.0.0 # Apache-2.0/BSD
    # flake8-docstrings~=1.7.0 # MIT
    # hacking~=6.0.1 # Apache-2.0
    oslo-messaging
    oslotest
    # PyJWT>=2.4.0 # MIT
    python-memcached
    requests-mock
    stestr
    # stevedore>=1.20.0 # Apache-2.0
    testresources
    # testtools>=2.2.0 # MIT
    webtest
  ];

  checkPhase = ''
    stestr run
  '';

  pythonImportsCheck = [ "futurist" ];
}
