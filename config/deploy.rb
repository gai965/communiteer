
lock "~> 3.16.0"

set :application, "communiteer"
set :repo_url, "https://github.com/gai965/communiteer.git"

set :rbenv_ruby, File.read('.ruby-version').strip
set :branch, ENV['BRANCH'] || "master"

# Nginxの設定ファイル名と置き場所を修正
set :nginx_config_name, "#{fetch(:application)}.conf"
set :nginx_sites_enabled_path, "/etc/nginx/conf.d"

append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "node_modules"


namespace :deploy do
  desc 'Load seed data into database'
  task :seed do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end
end

after 'deploy:migrate', 'deploy:seed'