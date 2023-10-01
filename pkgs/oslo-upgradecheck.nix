{ buildPythonPackage
, fetchFromGitea

, pbr

, oslo-config
, oslo-i18n
, oslo-policy
, oslo-utils
, prettytable

, oslotest
, stestr
}:

buildPythonPackage rec {
  pname = "oslo-upgradecheck";
  version = "2.2.0";

  # Manually set version because prb wants to get it from the git
  # upstream repository (and we are installing from tarball instead)
  PBR_VERSION = version;

  src = fetchFromGitea {
    domain = "opendev.org";
    owner = "openstack";
    repo = "oslo.upgradecheck";
    rev = version;
    sha256 = "sha256-7zHer3f0WenUVyuNSx58Sd1OXYp/5ZDaStsLP/0FkSQ=";
  };

  nativeBuildInputs = [
    pbr
  ];

  propagatedBuildInputs = [
    oslo-config
    oslo-i18n
    oslo-policy
    oslo-utils
    prettytable
  ];

  nativeCheckInputs = [
    oslotest
    stestr
  ];

  checkPhase = ''
    stestr run
  '';

  pythonImportsCheck = [ "oslo_upgradecheck" ];
}
