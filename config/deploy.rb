# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'doto.mcorp.ws'
set :repo_url, 'git@github.com:mcorp/doto.git'

set :deploy_to, "/var/www/#{fetch :application}"
