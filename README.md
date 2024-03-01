# Ubuntu Server Configuration for Ruby on Rails w/ Capistrano deployments

This repo contains the scripts (and the configuration files to go with them) for provisioning Ubuntu 20.04 for use with Ruby on Rails w/ Capistrano.

Features:
- Nginx, RVM, Redis, and ImageMagick installation
- Services and socket configuration for Rails and Sidekiq
- Staging or Production Nginx configuration
- Sample Capistrano files for deployment
- Others (AWS Cloudwatch, GeoIPUpdate, etc.)


Prerequisites:
- Firewall settings: you have already configured the server's and/or the hosting service's firewall
- SSH settings: you have already configured your development server with the ability to login via SSH to staging and production instances


Instructions:
1. Server setup
- Download this repo to the home directory of the server
- Run "provision_server" (./bin/provision_server) and answer the prompts
- Create a "rails.conf" file in the /etc/environment.d/ directory, and set any needed variables there. For example:

```
# /etc/environment.d/rails.conf
RAILS_ENV=production
DOMAIN_NAME=example.com
```


2. Add the following to your Gemfile (development group)
   gem "capistrano", require: false
   gem "capistrano-rails", require: false
   gem "capistrano-bundler", require: false
   gem 'capistrano-rvm', require: false
   gem 'elbas', require: false

3. Copy the default Capistrano files into your rails repo
   Capfile > (project_root)
   deploy.rb > config/
   deploy > config/

4. Modify the production/staging file configuration to suit your needs



5. Install certbot (if staging), and obtain SSL certificate
That's it. Enjoy!
