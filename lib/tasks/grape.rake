namespace :grape do
  desc "Print compiled grape routes"
  task routes: :environment do
    API::Base.routes.each do |route|
      method = route.route_method.ljust(10)
      path   = route.route_path

      puts "     #{method} #{path}"
    end
  end
end
