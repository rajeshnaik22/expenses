require 'resque'
require 'resque/tasks'

task "resque:setup" => :environment

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)