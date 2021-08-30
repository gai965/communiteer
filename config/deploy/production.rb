server "54.249.174.89", user: "deploy", roles: %w{app db web}

set :ssh_options, {
  keys: %w(~/.ssh/communiteer-app.pem),
  forward_agent: true,
  auth_methods: %w(publickey),
}