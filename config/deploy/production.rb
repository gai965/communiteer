server "54.249.174.89", user: "ec2-user", roles: %w{app db web}
set :deploy_to, '/var/www/communiteer'

set :ssh_options, {
  keys: %w(~/.ssh/communiteer-app.pem),
  forward_agent: true,
  auth_methods: %w(publickey),
}