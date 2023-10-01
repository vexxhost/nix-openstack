{ buildPythonPackage
, fetchPypi

, hatchling
}:

buildPythonPackage rec {
  pname = "uhashring";
  version = "2.3";
  format = "pyproject";

  src = fetchPypi {
    pname = "uhashring";
    inherit version;
    sha256 = "sha256-n3YYfo2OgvblUZyZXu8fG/RNSl4PxP3RIZoESxAEBhI=";
  };

  nativeBuildInputs = [
    hatchling
  ];
}
