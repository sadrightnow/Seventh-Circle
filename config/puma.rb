# Set up Puma to use a configurable number of threads
threads_count = ENV.fetch("RAILS_MAX_THREADS", 3).to_i
threads threads_count, threads_count

# Specifies the port that Puma will listen on to receive requests
port ENV.fetch("PORT", 3000)

# Specifies the environment Puma will run in
environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the address Puma will bind to for Fly.io compatibility
bind "tcp://0.0.0.0:#{ENV.fetch("PORT") { 3000 }}"

# Allow Puma to be restarted by the `bin/rails restart` command.
plugin :tmp_restart

# Specify the PID file for Puma (optional)
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
