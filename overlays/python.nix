self: super:

{
  elasticsearch = super.elasticsearch.overridePythonAttrs (_: rec {
    pname = "elasticsearch";
    version = "2.4.1";
    src = super.fetchPypi {
      inherit pname version;
      sha256 = "sha256-/q1H6/yqvRxT2/whQD65msIH7vdt6AAv4RocjslYnOI=";
    };
  });

  sqlalchemy = super.sqlalchemy.overridePythonAttrs (_: rec {
    pname = "SQLAlchemy";
    version = "1.4.49";
    src = super.fetchPypi {
      inherit pname version;
      sha256 = "sha256-Bv8ly64ww5bEt3N0ZPKn/Deme32kCZk7GCsCTOyArtk=";
    };
    disabledTestPaths = [
      # slow and high memory usage, not interesting
      "test/aaa_profiling"
    ];
    disabledTests = super.lib.optionals super.stdenv.isDarwin [
      "MemUsageWBackendTest"
      "MemUsageTest"
    ];
  });

  keystoneauth1 = super.keystoneauth1.overridePythonAttrs (_: rec {
    pname = "keystoneauth1";
    version = "5.3.0";
    src = super.fetchPypi {
      inherit pname version;
      sha256 = "sha256-AXwrm1mUU8kpQHUO27IPF2hxIbKJARS/nTbfFKBicRc=";
    };
  });

  futurist = self.callPackage ../pkgs/futurist.nix { };
  keystone = self.callPackage ../pkgs/keystone.nix { };
  keystonemiddleware = self.callPackage ../pkgs/keystonemiddleware.nix { };
  opentelemetry-api = self.callPackage ../pkgs/opentelemetry-api.nix { };
  opentelemetry-exporter-otlp-proto-common = self.callPackage ../pkgs/opentelemetry-exporter-otlp-proto-common.nix { };
  opentelemetry-exporter-otlp-proto-http = self.callPackage ../pkgs/opentelemetry-exporter-otlp-proto-http.nix { };
  opentelemetry-exporter-otlp = self.callPackage ../pkgs/opentelemetry-exporter-otlp.nix { };
  opentelemetry-proto = self.callPackage ../pkgs/opentelemetry-proto.nix { };
  opentelemetry-sdk = self.callPackage ../pkgs/opentelemetry-sdk.nix { };
  opentelemetry-semantic-conventions = self.callPackage ../pkgs/opentelemetry-semantic-conventions.nix { };
  oslo-cache = self.callPackage ../pkgs/oslo-cache.nix { };
  oslo-messaging = self.callPackage ../pkgs/oslo-messaging.nix { };
  oslo-metrics = self.callPackage ../pkgs/oslo-metrics.nix { };
  oslo-middleware = self.callPackage ../pkgs/oslo-middleware.nix { };
  oslo-policy = self.callPackage ../pkgs/oslo-policy.nix { };
  oslo-service = self.callPackage ../pkgs/oslo-service.nix { };
  oslo-upgradecheck = self.callPackage ../pkgs/oslo-upgradecheck.nix { };
  osprofiler = self.callPackage ../pkgs/osprofiler.nix { };
  pycadf = self.callPackage ../pkgs/pycadf.nix { };
  python-binary-memcached = self.callPackage ../pkgs/python-binary-memcached.nix { };
  uhashring = self.callPackage ../pkgs/uhashring.nix { };
}
