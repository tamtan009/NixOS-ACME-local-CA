{config,...}:{
  services = {
    nginx = {
      enable = true;
      virtualHosts = {
        "sql.lan" = {
          serverName = "sql.lan";
          locations."/.well-known/acme-challenge" = {
            root = "/var/lib/acme/acme-challenge";
          };
        };

        ${config.services.firefly-iii.virtualHost} = {
          sslCertificate = "/var/lib/acme/fin.lan/fullchain.pem";
          sslCertificateKey = "/var/lib/acme/fin.lan/key.pem";
          onlySSL = true;
          serverName = "fin.lan";
          listen = [{
            port = 443;
            addr = "0.0.0.0";
            ssl = true;
          }];
        };

      };
    };
  };
}
