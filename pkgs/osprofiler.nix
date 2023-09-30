{ buildPythonPackage
, fetchFromGitea
, pbr
, requests
, webob
, prettytable
, oslo-utils
, oslo-serialization
, oslo-concurrency
}:

buildPythonPackage rec {
  pname = "osprofiler";
  version = "4.1.0";

  # Manually set version because prb wants to get it from the git
  # upstream repository (and we are installing from tarball instead)
  PBR_VERSION = version;

  src = fetchFromGitea {
    domain = "opendev.org";
    owner = "openstack";
    repo = pname;
    rev = version;
    sha256 = "sha256-UVZpPsjjmnIwXi7z8wkMuJOVYaixC7EMEycG3QxiZbI=";
  };

  nativeBuildInputs = [
    pbr
  ];

  propagatedBuildInputs = [
    requests
    webob
    prettytable
    oslo-utils
    oslo-serialization
    oslo-concurrency
  ];
}
