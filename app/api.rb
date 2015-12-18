module API
  module Entities; end
  module Utils; end
end

current_path = File.dirname(__FILE__)
Dir["#{current_path}/api/entities/**/*.rb",
  "#{current_path}/api/utils/**/*.rb",
  "#{current_path}/api/*.rb"].each {|file| require file }