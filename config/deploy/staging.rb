server "35.196.91.83",
  user: "root",
  roles: %w{web db app},
  ssh_options: {
    keys: %w(~/.ssh/id_rsa),
    forward_agent: false,
    auth_methods: %w(publickey password)
    # password: "please use keys"
  }

  namespace :deploy do
    desc 'Restart Unicorn'
    task :restart_unicorn do
      invoke 'unicorn:legacy_restart'
    end
  end
