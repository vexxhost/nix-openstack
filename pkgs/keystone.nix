{ buildPythonPackage
, fetchFromGitea

, pbr

, bcrypt
, cryptography
, dogpile-cache
, flask
, flask-restful
, jsonschema
, keystonemiddleware
, msgpack
, oauthlib
, oslo-cache
, oslo-config
, oslo-context
, oslo-db
, oslo-i18n
, oslo-log
, oslo-messaging
, oslo-middleware
, oslo-policy
, oslo-serialization
, oslo-upgradecheck
, oslo-utils
, osprofiler
, passlib
, pycadf
, pyjwt
, pysaml2
, python-keystoneclient
, pytz
, scrypt
, sqlalchemy
, stevedore
, webob

, freezegun
, hacking
, ldappool
, oslotest
, pycodestyle
, python-ldap
, stestr
, webtest
, which
}:

buildPythonPackage rec {
  pname = "keystone";
  version = "22.0.0-0";

  # Manually set version because prb wants to get it from the git
  # upstream repository (and we are installing from tarball instead)
  PBR_VERSION = version;

  src = fetchFromGitea {
    domain = "opendev.org";
    owner = "openstack";
    repo = pname;
    rev = "0f6b645ce8ffbca9a33c5ab971a46941e96b8c1c";
    sha256 = "sha256-riHWT8Mdlfi+B2/WxlypjTp8iCbn2p9irKzq/ewB6fs=";
  };

  nativeBuildInputs = [
    pbr
  ];

  propagatedBuildInputs = [
    bcrypt
    cryptography
    dogpile-cache
    flask
    flask-restful
    jsonschema
    keystonemiddleware
    msgpack
    oauthlib
    oslo-cache
    oslo-config
    oslo-context
    oslo-db
    oslo-i18n
    oslo-log
    oslo-messaging
    oslo-middleware
    oslo-policy
    oslo-serialization
    oslo-upgradecheck
    oslo-utils
    osprofiler
    passlib
    pycadf
    pyjwt
    pysaml2
    python-keystoneclient
    pytz
    scrypt
    sqlalchemy
    stevedore
    webob
  ];

  nativeCheckInputs = [
    freezegun
    hacking
    ldappool
    oslotest
    pycodestyle
    python-ldap
    stestr
    webtest
    which
  ];

  preConfigure = ''
    substituteInPlace keystone/tests/unit/test_policy.py \
      --replace "oslopolicy-policy-generator" "${oslo-policy}/bin/oslopolicy-policy-generator"
  '';

  checkPhase = ''
    stestr run
  '';
}
