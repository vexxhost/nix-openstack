{ buildPythonPackage
, fetchPypi

, setuptools

, uhashring
, six
}:

buildPythonPackage rec {
  pname = "python-binary-memcached";
  version = "0.31.2";
  format = "pyproject";

  src = fetchPypi {
    pname = "python-binary-memcached";
    inherit version;
    sha256 = "sha256-KQ9wRR4nffajmqDuo8tsou789dYB+VfPLsHTU9dnbAM=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    uhashring
    six
  ];
}
