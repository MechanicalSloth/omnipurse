#!/usr/local/bin/ruby

if ARGV.count == 0
  # No args passed, doing normal lunch...
  # Starting nginx
  fork do
    exec 'nginx'
  end
  # Starting puma
  fork do
    exec 'puma -b unix:///var/run/puma.sock'
  end
  # Sleep main process
  sleep
else
  # Args passed, starting custom command
  command = ARGV.join(' ')
  exec command
end
