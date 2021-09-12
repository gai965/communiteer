
lock "~> 3.16.0"

set :application, "communiteer"
set :repo_url, "https://github.com/gai965/communiteer.git"

set :rbenv_ruby, File.read('.ruby-version').strip
set :branch, ENV['BRANCH'] || "master"

set :deploy_to, '/var/www/rails/communiteer'

# Nginxの設定ファイル名と置き場所を修正
set :nginx_config_name, "#{fetch(:application)}.conf"
set :nginx_sites_enabled_path, "/etc/nginx/conf.d"

append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "node_modules"