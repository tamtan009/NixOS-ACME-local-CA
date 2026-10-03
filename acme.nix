{...}:{
  security = {
    acme = {
      acceptTerms = true;
      certs = {
        "fin.lan" = {
          server = "https://ca.lan:8443/acme/acme/directory";
          group = "nginx";
          listenHTTP = ":80";
          extraLegoRunFlags = [
            "http"
          ];
         };
        "sql.lan" = {
          server = "https://ca.lan:8443/acme/acme/directory";
          listenHTTP = ":80";
          extraLegoRunFlags = [
            "http"
          ];
          postRun = ''
            install -m 0644 -o postgres -g postgres /var/lib/acme/sql.lan/fullchain.pem /var/lib/postgresql/17/sql.crt
            install -m 0600 -o postgres -g postgres /var/lib/acme/sql.lan/key.pem /var/lib/postgresql/17/sql.key
          '';
          reloadServices = ["postgresql"];
        };
      };
    };
  };
}
