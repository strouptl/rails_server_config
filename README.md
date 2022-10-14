# Ubuntu Server Configuration for Ruby on Rails w/ Capistrano deployments

This repo contains the scripts (and the configuration files to go with them) for provisioning Ubuntu 20.04 for use with Ruby on Rails w/ Capistrano.

Features:
- Nginx, RVM, NodeJS, Redis, and ImageMagick installation
- Services and socket configuration (Rails and Sidekiq)
- Nginx configuration
- Logrotate settings
- Environment variables

Prerequisites:
- Firewall settings: you have already configured the server's firewall
- SSH settings: you have already configured the server for SSH
- Capistrano settings: you have already configured Capistrano for deploying to this server

Instructions:
- Copy this repo to the home directory of the server
- Run "provision_server" and "update_config_files" (./bin/provision_server)
- set ":deploy_to" in your deploy.rb file for capistrano to "/var/www/rails"
- Create a "rails.conf" file in the /etc/environment.d/ directory, and set any needed variables there. For example:

```
# /etc/environment.d/rails.conf
RAILS_ENV=production
DOMAIN_NAME=example.com
```

WARNING: If configuring the server for SSL settings, you will need to modify the nginx file for Rails. Make sure you do not rerun "update_config_files" after this, or it will overwrite your SSL settings;

That's it. Enjoy!
