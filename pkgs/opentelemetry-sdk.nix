{ buildPythonPackage
, fetchPypi

, hatchling

, opentelemetry-api
, opentelemetry-semantic-conventions
, typing-extensions
}:

buildPythonPackage rec {
  pname = "opentelemetry-sdk";
  version = "1.20.0";
  format = "pyproject";

  src = fetchPypi {
    pname = "opentelemetry_sdk";
    inherit version;
    sha256 = "sha256-cC5DKkV/pxf9Ld/TBkAYDmmTj4W7f+w+R5+F9hwYQ/g=";
  };

  nativeBuildInputs = [
    hatchling
  ];

  propagatedBuildInputs = [
    opentelemetry-api
    opentelemetry-semantic-conventions
    typing-extensions
  ];
}
