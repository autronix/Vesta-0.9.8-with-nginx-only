[Vesta Control Panel](http://vestacp.com/)
==================================================

* Vesta is an open source hosting control panel.
* Vesta has a clean and focused interface without the clutter.
* Vesta has the latest of very innovative technologies.

These files are intended as a replacement for the default Nginx config template files in order to bypass the proxy and use Nginx + PHP-fpm as the main webserver. It should also ease configuration for those who wish to add Rails application with Nginx + Puma.

Disclaimer: Use at your own risk. By downloading and using these files you agree that I will not be held responsible in any for any loss of data, damaged system, fire.

Note: I have only tried this on CentOS 6.5 but it would probably work on other distros.


How to allow the Vesta Web manager to run with Nginx as the webserver
----

Prerequisites: download and install php-fpm:

``` 
 sudo yum --enablerepo=remi install php-fpm php-mysql
```

Backup your original template files (CentOS 6.5/RHEL path displayed below, please check the path on your system):

```
 cd /usr/local/vesta/data/templates/web/nginx
 mkdir bkp
 mv *.*tpl ./bkp
 cp ./bkp/ip_proxy.tpl ./
```

Upload the files to %Vesta_install_Path%/data/templates/web/nginx

Turn off Apache:

``` 
 service httpd stop
 chkconfig httpd off
```

Check that Apache is stopped:

```
 service httpd status
```

That is all. Next time you create a web domain from vesta it will be configured to use Nginx + PHP-fpm as a webserver instead of proxying for apache.

Good luck
