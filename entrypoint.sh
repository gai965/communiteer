#!/bin/bash
set -e

# railsエラーを招くプロセスを削除する
rm -f /myapp/tmp/pids/server.pid

# データベースをマイグレーションする
rails db:migrate
rails db:seed

# webpackeによるコンパイル
rails webpacker:compile

# DockerfileのCMDに動作が移る設定
exec "$@"
