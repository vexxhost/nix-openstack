{ buildPythonPackage
, fetchFromGitea

, pbr

, dogpile-cache
, oslo-config
, oslo-i18n
, oslo-log
, oslo-utils

, oslotest
, pifpaf
, pymemcache
, pymongo
, python-binary-memcached
, python-memcached
, stestr
}:

buildPythonPackage rec {
  pname = "oslo-cache";
  version = "3.5.0";
  format = "pyproject";

  # Manually set version because prb wants to get it from the git
  # upstream repository (and we are installing from tarball instead)
  PBR_VERSION = version;

  src = fetchFromGitea {
    domain = "opendev.org";
    owner = "openstack";
    repo = "oslo.cache";
    rev = version;
    sha256 = "sha256-f/8MtMmKpUbUXFhTa3GkZ1P6S6YLmN1PgFR/T+2KL6E=";
  };

  nativeBuildInputs = [
    pbr
  ];

  propagatedBuildInputs = [
    dogpile-cache
    oslo-config
    oslo-i18n
    oslo-log
    oslo-utils
  ];

  nativeCheckInputs = [
    oslotest
    pifpaf
    pymemcache
    pymongo
    python-binary-memcached
    python-memcached
    stestr
  ];

  checkPhase = ''
    stestr run
  '';

  pythonImportsCheck = [ "oslo_cache" ];
}
