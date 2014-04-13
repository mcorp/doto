# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'doto.mcorp.ws'
set :repo_url, 'git@github.com:mcorp/doto.git'

set :deploy_to, "/var/www/#{fetch :application}"

set :linked_dirs, %w{bin log tmp/backup tmp/pids tmp/cache tmp/sockets public}
set :linked_files, %w{config/database.yml config/unicorn.rb}
