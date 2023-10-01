{ buildPythonPackage
, fetchPypi

, hatchling

, protobuf
}:

buildPythonPackage rec {
  pname = "opentelemetry-proto";
  version = "1.20.0";
  format = "pyproject";

  src = fetchPypi {
    pname = "opentelemetry_proto";
    inherit version;
    sha256 = "sha256-zwH0mzBy7ldGi8yxpPk721VBH0US0Kw/l8XATABAtaI=";
  };

  nativeBuildInputs = [
    hatchling
  ];

  propagatedBuildInputs = [
    protobuf
  ];
}
