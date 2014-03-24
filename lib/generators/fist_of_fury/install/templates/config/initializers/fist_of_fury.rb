# Ensure the jobs run only in a web server.
if defined?(Rails::Server)
  FistOfFury.attack! do
    # Jobs can be scheduled here. Example:
    # SayHiJob.recurs { secondly(3) }
  end
end
