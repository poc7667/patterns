require 'pry'
require "action_controller"
require "application_controller"
require "router"
require "./config/routes"

class Application

  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new
    controller_name, action_name = route(request.env['REQUEST_METHOD'].to_sym, request.path_info)
    controller_class = load_controller_class(controller_name) # HomeController
    controller = controller_class.new # HomeController.new
    controller.request = request
    controller.response = response
    controller.process action_name # calls: controller.index

    response.finish
  end

  def route(req_method, path)
    # => "/home/i
    controller_name, action_name = Routes.recognize(req_method, path.chomp("/"))
    [controller_name || "home", action_name || "index"]
    # _, controller_name, action_name = path.split("/")
    # [controller_name || "home", action_name || "index"]
  end

  def load_controller_class(name)
    # name = "home" => HomeController
    p name
    require "#{name}_controller" # require "home_controller"
    Object.const_get name.capitalize + "Controller" # "HomeController"
  end
end
