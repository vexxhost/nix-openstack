{ buildPythonPackage
, fetchPypi

, hatchling
}:

buildPythonPackage rec {
  pname = "opentelemetry-exporter-otlp";
  version = "1.20.0";
  format = "pyproject";

  src = fetchPypi {
    pname = "opentelemetry_exporter_otlp";
    inherit version;
    sha256 = "sha256-+Mtp+AwzMWblz6oDD54o9/qvNDr/JMqqLLQgLqSEm2s=";
  };

  nativeBuildInputs = [
    hatchling
  ];
}
