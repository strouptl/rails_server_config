# Ruby on Rails server config for Capistrano Deployment

This repo contains the scripts (and the configuration files to go with them) for provisioning Ubuntu 20.04 for use with Ruby on Rails w/ Capistrano.

## Features:
- Nginx, RVM, Redis, and ImageMagick installation
- Services and socket configuration for Rails and Sidekiq
- Staging and Production Nginx configuration
- Staging and Production Capistrano files for deployment
- AWS Load Balancing
- Others (AWS Cloudwatch, GeoIPUpdate, etc.)


## Prerequisites: SSH
1. Create a public key if needed in your development environment

 ```
 sudo apt-get install ssh-keygen
 cd ~/.ssh
 ssh-keygen
 ```

 Reference: https://git-scm.com/book/en/v2/Git-on-the-Server-Generating-Your-SSH-Public-Key

2. Add the public key (identified by id_rsa.pub) to the ~/.ssh/known_hosts file on the target server

3. Make sure you can SSH into the target server.

## Server setup
1. Clone this repo to the home directory of the target server

```
git clone https://github.com/strouptl/rails_server_config"
```

2. Run the "provision_server" script and answer the prompts

```
cd rails_server_config
./bin/provision_server
```

3. Create a "rails.conf" file in the /etc/environment.d/ directory, and set any needed environment variables there.

For example:
```
# /etc/environment.d/rails.conf
RAILS_ENV=production
DOMAIN_NAME=example.com
```

4. Consider setting the RAILS_ENV and any other essential environment variables in your local bash shell, as well (rails.conf will only load within the service)

```
# ~/.profile
RAILS_ENV=production
DOMAIN_NAME=example.com
```

## Capistrano Setup
1. Add the following to your Gemfile (development group)

```
# Gemfile
group :development do
  gem "capistrano", require: false
  gem "capistrano-rails", require: false
  gem "capistrano-bundler", require: false
  gem 'capistrano-rvm', require: false
  gem 'elbas', require: false
end
```

2. Install Capistrano to generate the default Capistrano files

```
bundle exec cap install
```

3. Update the contents of the default Capistrano files as needed from the cap_files directory of this repo:

```
 Capfile > (project_root)
 deploy.rb > config/
 deploy/* > config/deploy/*
```

References: https://github.com/capistrano/capistrano/blob/master/README.md#install-the-capistrano-gem

4. Add the following environment variables to the .env file in your rails repo

```
AWS_REGION=
CAP_AWS_ACCESS_KEY_ID=
CAP_AWS_SECRET_ACCESS_KEY=
```

NOTE: This AWS user must have full access to EC2 in order to interact with the Target Group and/or Templates. Keep it safe, and keep it separate from other AWS Credentials.

## Final DNS/Hosting Configuration 

### Staging

1. Point your desired domain name (e.g. www.example.com) to the IP address of your server.

2. Install certbot, and obtain SSL certificate

```
sudo apt-get install certbot
sudo certbot
```

References: https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal

### Production

1. Create a Launch Template from your production server above

2. Create a Target Group referencing this Launch Template

3. Create an AWS Scaling Group, referencing the Target Group above

4. Create an SSL Certificate for your desired domain name via AWS Certificat Manager

5. Create a Load Balancer with this certificate, and configure it to forward traffic to the desired AWS Target Group

NOTE: The above is a rough outline of the general requirements for utilizing AWS Autoscaling. For Steps 2~5, we recommend utilizing Terraform/OpenTofu for configuring the cloud environment properly (coming soon!).
