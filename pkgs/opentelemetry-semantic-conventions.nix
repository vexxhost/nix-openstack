{ buildPythonPackage
, fetchPypi

, hatchling
}:

buildPythonPackage rec {
  pname = "opentelemetry-semantic-conventions";
  version = "0.41b0";
  format = "pyproject";

  src = fetchPypi {
    pname = "opentelemetry_semantic_conventions";
    inherit version;
    sha256 = "sha256-DOWwQLij/IFupYeadDs9b+XbYfZIXk3vlMbuTUAuHrc=";
  };

  nativeBuildInputs = [
    hatchling
  ];
}
