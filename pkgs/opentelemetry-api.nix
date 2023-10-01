{ buildPythonPackage
, fetchPypi

, hatchling

, deprecated
, importlib-metadata
}:

buildPythonPackage rec {
  pname = "opentelemetry-api";
  version = "1.20.0";
  format = "pyproject";

  src = fetchPypi {
    pname = "opentelemetry_api";
    inherit version;
    sha256 = "sha256-BqvjUdt1cviv3Q+4ic5T88mS2/b2JiUHs4XMGWPgaYM=";
  };

  nativeBuildInputs = [
    hatchling
  ];

  propagatedBuildInputs = [
    deprecated
    importlib-metadata
  ];
}
