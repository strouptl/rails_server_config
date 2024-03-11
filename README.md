# Ruby on Rails server config for Capistrano Deployment

This repo contains the scripts (and the configuration files to go with them) for provisioning Ubuntu 20.04 for use with Ruby on Rails w/ Capistrano.

## Features:
- Nginx, RVM, Redis, and ImageMagick installation
- Services and socket configuration for Rails and Sidekiq
- Staging and Production Nginx configuration
- Staging and Production Capistrano files for deployment
- AWS Load Balancing
- Others (AWS Cloudwatch, GeoIPUpdate, etc.)


## Prerequisites:
- Firewall settings: you have already configured the server's and/or the hosting service's firewall
- SSH settings: you have already configured your development server with the ability to login via SSH to staging and production instances


## Server setup
- Download this repo to the home directory of the server
- Run "provision_server" (./bin/provision_server) and answer the prompts
- Create a "rails.conf" file in the /etc/environment.d/ directory, and set any needed environment variables there. For example:

```
# /etc/environment.d/rails.conf
RAILS_ENV=production
DOMAIN_NAME=example.com
```


## Capistrano Setup
1. Add the following to your Gemfile (development group)

```
 gem "capistrano", require: false
 gem "capistrano-rails", require: false
 gem "capistrano-bundler", require: false
 gem 'capistrano-rvm', require: false
 gem 'elbas', require: false
```

2. Run "bundle exec cap install" from your rails repo to generate the default Capistrano files

3. Update the contents of the default Capistrano files as needed from the cap_files directory of this repo:

```
 Capfile > (project_root)
 deploy.rb > config/
 deploy/* > config/deploy/*
```

References: https://github.com/capistrano/capistrano/blob/master/README.md#install-the-capistrano-gem

3. Create a (or use an existing) .env file in your rails repo, and populate the needed AWS environment variable keys

NOTE: this AWS user must have full access to EC2 in order to interact with the Target Group and/or Templates. Keep it safe, and keep it separate from other AWS Credentials.

```
AWS_REGION=
CAP_AWS_ACCESS_KEY_ID=
CAP_AWS_SECRET_ACCESS_KEY=
```

## Finalize Nginx Configuration 

### Staging
Install certbot, and obtain SSL certificate

```
sudo apt-get install certbot
sudo certbot
```

References: https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal

### Production
1. Configure your servers to utilize a self-signed SSL certificate with Nginx
Already done, if you used the "production" option when provisioning the server

2. Configure a load balancer to forward traffic to your servers via target group
