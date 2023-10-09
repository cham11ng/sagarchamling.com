---
title: "Linux Server Stack Setup in Ubuntu 16.04 LTS"
summary: "Learn to setup LEPP manually in Ubuntu Server."
description: "Learn to setup LEPP manually in Ubuntu Server."
date: 2018-02-11
draft: false
author: ["Anup Dhakal", "Sagar Chamling"]
tags: ['linux', 'nginx', 'postgres', 'php']
---
> Credit: Anup Dhakal (https://anupdhakal.com)
>
## Introduction

In this guide, **LEPP** stands for **Linux**, **Nginx** (pronounced as Engine-X) , **Postgres** and **PHP** (PHP Hypertext Preprocessor).

### Specifications/Target

* **Ubuntu**    v16.04
* **Nginx**     v1.10
* **PHP**       v7.1
* **Postgres**   v9.6.3
* **phpPgAdmin** v5.2

But before we start, let's quickly make sure that we have some basic tools ready. Run the following commands in the terminal.

```shell
sudo apt update
sudo apt install wget
sudo apt install software-properties-common
```

Now let's start!

## Custom Repositories

Before beginning the installation, we want to add some repositories which will give us the latest corresponding packages for our server stack.

### Nginx Repository

For Ubuntu, in order to authenticate the Nginx repository signature and to eliminate warnings about missing PGP key during installation of the Nginx package, it is necessary to add the key used to sign the Nginx packages and repository to the apt program keyring. Only after then we will dare to add the repositories.

_The above fact is true every time we add a custom repository. If we don't want to add any custom repository and use the ones provided to us by "vanilla" Ubuntu itself, we can just ignore this section of the guide, entirely. We have to keep in mind that the version numbers used in this guide are according to the default, most recent versions of the respective packages at the time of creation of this guide. So, we might have to be careful in coming sections of the guide where we start installation and setup of the stack. We would want to make sure then, that the version number would match to what we have installed, not what is shown in this guide._

Run the following code one by one in the terminal to add the Nginx stable repository. We need to accept any prompts, if asked.

```shell
wget http://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key
sudo sed -i '$a deb http://nginx.org/packages/ubuntu/ xenial nginx' /etc/apt/sources.list
sudo sed -i '$a # deb-src http://nginx.org/packages/ubuntu/ xenial nginx' /etc/apt/sources.list
```

### Postgres Repository

The PostgreSQL apt repository supports LTS versions of Ubuntu 16.04 on amd64 and i386 architectures. This repository will integrate with your normal systems and patch management, and provide automatic updates for all supported versions of PostgreSQL throughout the support lifetime of PostgreSQL.

* Create the file `/etc/apt/sources.list.d/pgdg.list`, and add a line for the repository

```shell
deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main
```

* Import the repository signing key, and update the package lists

```shell
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  sudo apt-key add -
```

### PHP Repository

The repository here we are going to install is the PHP PPA by [Ondrej](https://launchpad.net/~ondrej/+archive/ubuntu/php "Ondrej PHP PPA"). We can update our system with unsupported packages from this untrusted PPA by adding ppa:ondrej/php to our system's Software Sources. The following commands will help us to do so. We need to accept any prompts, if asked.

```shell
sudo add-apt-repository ppa:ondrej/php
```

_We might feel a little bit confused by the terms "untrusted PPA", but there is actually no reason to worry. We just need to remember that, unlike Nginx's or the MariaDB's repositories, this is **not** an official upgrade path. But the PPA is well known, and is relatively safe to use._

## Update APT

Let's finally begin the actual installations processes.

First, we want to make sure we have the latest records in our local packages registry. Let's run the following command in the terminal like so.

```shell
sudo apt update
```

## Installing Nginx

First thing we’re going to install is the server called Nginx.

```shell
sudo apt install nginx
```

We can check if Nginx is installed by typing `nginx -v`  in the terminal.

## Installing Postgres

```shell
sudo apt-get install postgresql postgresql-contrib
```

We can check if Postgres is installed by executing `psql --version` in the terminal.

_PHP makes use of the package `php-pgsql` as the database driver for Postgres._

## Installing PHP

Next thing we want to install is PHP. We need to install PHP with a few extensions that are mandatory for modern web applications.

```shell
sudo apt install php-cli php-fpm php-zip php-xml php-mbstring php-mcrypt php-curl php-gd php-pgsql php-bz2 php-gettext php-pear php-phpseclib php-tcpdf
```

We may run `php -v`  in the terminal to check the version of PHP installed.

## Configuring Nginx

We don't need to change anything right now. But if we want to, we can change the main configuration of Nginx as follows:

```shell
sudo gedit /etc/nginx/nginx.conf
```

In the config file, notice the line with `user nginx`. This means Nginx will run as the user **nginx**. We should not forget to run `sudo systemctl restart nginx.service` if we make changes to any configuration file of Nginx.

### Configuring PHP to work with Nginx

In order for PHP and Nginx to work together, we need to configure both of them. _We need to make sure that PHP-FPM (FastCGI Process Manager) runs as the **same user** as Nginx._ And for that we need to run `sudo gedit /etc/php/7.1/fpm/pool.d/www.conf` in the terminal and change the relevant lines as:

```ini
...
user = nginx
group = nginx
...
listen.owner = nginx
listen.group = nginx
...
```

_Note the command where we used ... php/**7.1**/fpm ... . We want to make sure that **7.1** is the version that we actually have installed in our system. Refer [this](#installing-php) section to go back and see how we installed PHP and PHP-FPM, and how to see the version of PHP installed._

We need to run `sudo systemctl restart php7.1-fpm.service` in the terminal to load the new configuration.

### Default Site

Now comes the fun part where we create a default site that supports PHP. In our case, we want `~/www` as our directory of all websites. Normally, `/var/www` is used as the default one. Here we want to change it to a custom directory inside our home directory, as mentioned above.

First, we want to make sure the directory exists. Let's create a default site directory `_default_` with command `mkdir -p ~/www/_default_/public`.

_Note that to add other sites, we can follow a similar pattern. We may create a new folder for each site, which has a `public` folder in it as the public entry point of the site._

Now to edit the default site configuration, let's run the following command in the terminal

```shell
sudo gedit /etc/nginx/conf.d/default.conf
```

and replace its content with this:

```nginx
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /home/[OUR_USERNAME]/www/_default_/public;

    index index.html index.htm index.php;

    server_name _;

    location / {
        try_files $uri $uri/ =404;
        autoindex on;
    }

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/run/php/php7.1-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

}
```

_Please note that we need to change **[OUR\_USERNAME]** from above config file to our actual username._

Now let's run `sudo systemctl restart nginx.service` to reload our new configuration.

Now we should be able to see on browser that [http://localhost](http://localhost "Localhost") actually works, and most probably shows an empty index.

**\*\*Ba Dum Tis\*\***

We can put any file in the `~/www/_default_/public` directory and it should be showing in the browser after a refresh.

## Configuring Postgres

Switch over to the postgres account on your server by typing:

```
user@aspire:~$ sudo -i -u postgres
```

Let's Create a New Role

```
postgres@aspire:~$ createuser --interactive -P
Enter name of role to add: {role name}
Enter password for new role: 
Enter it again: 
Shall the new role be a superuser? (y/n) 
```

## Installing phpPgAdmin

### Setting Up Host

We want to be able to lunch phpPgAdmin by going to [http://phppgadmin.app](http://phppgadmin.app "phpPgAdmin") in the address bar of the browser.

So, first of all, run `sudo gedit /etc/hosts` and add an entry as follows:

```shell
127.1.1.1    phppgadmin.app
```

### phpPgAdmin

Run the following commands to install phpmyadmin:

```shell
cd /usr/share
sudo git clone git@github.com:phppgadmin/phppgadmin.git
cd phppgadmin/config
sudo cp config.inc.php-dist config.inc.php
```

If extra login security is true, then logins via phpPgAdmin with no password or certain usernames (pgsql, postgres, root, administrator) will be denied. Only set this false once you have read the FAQ and understand how to change PostgreSQL's pg_hba.conf to enable passworded local connections.

```php
$conf['servers'][0]['host'] = 'localhost';

$conf['extra_login_security'] = false;
```

### Setting Up Server Block

Now, we will setup an **Nginx server block** (a.k.a. virtual host in Apache httpd).

Let's run the command `sudo touch /etc/nginx/conf.d/phppgadmin.conf` to create a **site** (configuration file).

Let's open it with `sudo gedit /etc/nginx/conf.d/phppgadmin.conf` and add the contents as follows.

```nginx
server {
    listen 80;

    root /usr/share/phppgadmin; # make sure to enter the correct location of phppgadmin here
    index index.php index.html index.htm;

    server_name phppgadmin.app;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        try_files $uri /index.php =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/run/php/php7.1-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
```

### Activating the server block

Now we have to restart Nginx to activate our new site (config file) by running:

```shell
sudo systemctl restart nginx.service
```

Try hitting [http://phppgadmin.app](http://phppgadmin.app "phpPgGAdmin") and it should work!

## Conclusion

There we have it! We should by now have a working and relatively secure LEPP server stack with Nginx running at [http://localhost](http://localhost "Localhost"), as well as our phpPgAdmin app running at [http://phppgadmin.app](http://phppgadmin.app "phpPgAdmin")

_In this guide we didn't talk anything about firewall. This is because a fresh install of "vanilla" Ubuntu 16.04 should not have one running it automatically. We may research about it later if we wish to. Right now, that would be beyond the scope of this guide._

So, did you find this guide helpful? Feedbacks are precious. Suggestions are highly appreciated.
