{...}:{
  security = {
    acme = {
      acceptTerms = true;
      certs = {

        "fin.lan" = {
          server = "https://ca.lan:8443/acme/acme/directory";
          group = "nginx";
          webroot = "/var/lib/acme/acme-challenge";
         };
         
        "sql.lan" = {
          server = "https://ca.lan:8443/acme/acme/directory";
          webroot = "/var/lib/acme/acme-challenge";
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

