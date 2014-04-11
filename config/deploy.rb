# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'doto'
set :repo_url, 'git@github.com:mcorp/doto.git'

namespace :ruby do
  desc "lala"
  task :vai do
    on roles(:app, :web) do
      as :root do
        execute "gem update --system"
      end
    end
  end
end
