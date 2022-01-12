server "52.69.143.11", user: "ec2-user", roles: %w{app db web}
set :deploy_to, '/var/www/communiteer'

set :ssh_options, {
  keys: %w(~/.ssh/communiteer-keypair.pem),
  forward_agent: true,
  auth_methods: %w(publickey),
}