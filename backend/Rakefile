# frozen_string_literal: true

namespace :run do
  task :server do
    sh 'rackup -p 8233 --host 0.0.0.0'
  end
end
task run: 'run:server'

task default: 'run'
