{ buildPythonPackage
, fetchPypi

, hatchling

, backoff
, opentelemetry-proto
}:

buildPythonPackage rec {
  pname = "opentelemetry-exporter-otlp-proto-common";
  version = "1.20.0";
  format = "pyproject";

  src = fetchPypi {
    pname = "opentelemetry_exporter_otlp_proto_common";
    inherit version;
    sha256 = "sha256-32DGgb1hgS5Qs6Oaehr+621AZhF1gySfzCYiaTdOekk=";
  };

  nativeBuildInputs = [
    hatchling
  ];

  propagatedBuildInputs = [
    backoff
    opentelemetry-proto
  ];
}
