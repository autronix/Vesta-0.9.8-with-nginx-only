server {
    listen      %ip%:%proxy_port%;
    server_name %domain_idn% %alias_idn%;
    error_log  /var/log/httpd/domains/%domain%.error.log error;

    location / {
        
		proxy_cache cache;
        proxy_cache_valid 15m;
        proxy_cache_valid 404 1m;
        proxy_no_cache $no_cache;
        proxy_cache_bypass $no_cache;
        proxy_cache_bypass $cookie_session $http_x_update;
		
		location ~* ^.+\.(%proxy_extentions%)$ {
            root           %docroot%;
            access_log     /var/log/nginx/domains/%domain%.log combined;
            access_log     /var/log/nginx/domains/%domain%.bytes bytes;
            expires        max;
            #try_files      $uri;
        }
		
		root           %docroot%;
		index index.php  index.html index.htm;
		
    }

    location /error/ {
        alias   %home%/%user%/web/%domain%/document_errors/;
    }
	
	location ~ \.php$ {
			root           %docroot%;
			fastcgi_pass   127.0.0.1:9000;
			fastcgi_index  index.php;
			fastcgi_param  SCRIPT_FILENAME   $document_root$fastcgi_script_name;
			include        fastcgi_params;
	}

    location ~ /\.ht    {return 404;}
    location ~ /\.svn/  {return 404;}
    location ~ /\.git/  {return 404;}
    location ~ /\.hg/   {return 404;}
    location ~ /\.bzr/  {return 404;}

    disable_symlinks if_not_owner from=%docroot%;

    include %home%/%user%/conf/web/nginx.%domain%.conf*;
}