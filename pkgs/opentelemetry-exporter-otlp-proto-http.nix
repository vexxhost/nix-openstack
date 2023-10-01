{ buildPythonPackage
, fetchPypi

, hatchling

, backoff
, deprecated
, googleapis-common-protos
, opentelemetry-api
, opentelemetry-exporter-otlp-proto-common
, opentelemetry-proto
, opentelemetry-sdk
, requests
}:

buildPythonPackage rec {
  pname = "opentelemetry-exporter-otlp-proto-http";
  version = "1.20.0";
  format = "pyproject";

  src = fetchPypi {
    pname = "opentelemetry_exporter_otlp_proto_http";
    inherit version;
    sha256 = "sha256-UA9CghQg/fB1kZPWQ47cD06YSoPhTAiiMCPAahiIYbQ=";
  };

  nativeBuildInputs = [
    hatchling
  ];

  propagatedBuildInputs = [
    backoff
    deprecated
    googleapis-common-protos
    opentelemetry-api
    opentelemetry-exporter-otlp-proto-common
    opentelemetry-proto
    opentelemetry-sdk
    requests
  ];
}
