ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'



# Type `rake -T` on your command line to see the available rake tasks.

task :environment do
  require_relative './config/environment'
end
desc 'drop into the Pry console'
task :console => :environment do
  Pry.start
end
