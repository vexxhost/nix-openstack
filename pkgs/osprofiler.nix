{ buildPythonPackage
, fetchFromGitea

, pbr

, netaddr
, oslo-concurrency
, oslo-serialization
, oslo-utils
, prettytable
, requests
, webob

, ddt
, docutils
, elasticsearch
, jaeger-client
, opentelemetry-exporter-otlp
, opentelemetry-exporter-otlp-proto-http
, opentelemetry-sdk
, pymongo
, redis
, stestr
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
    netaddr
    oslo-concurrency
    oslo-serialization
    oslo-utils
    prettytable
    requests
    webob
  ];

  nativeCheckInputs = [
    ddt
    docutils
    elasticsearch
    jaeger-client
    opentelemetry-exporter-otlp
    opentelemetry-exporter-otlp-proto-http
    opentelemetry-sdk
    pymongo
    redis
    stestr
  ];

  checkPhase = ''
    stestr run
  '';

  pythonImportsCheck = [ "osprofiler" ];
}
