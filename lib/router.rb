class Router

  @@routes = {
    GET:{},
    POST:{}
  }

  def initialize(&block)
    instance_eval(&block)
  end

  def method_missing(name, *args, &block)
     if name.to_sym == :match
       path, action = args.first.to_a.flatten
       @@routes[:GET][path] = action
     else
       super
     end
  end

  def get(path, &block)
    @@routes[:GET][path] = block
  end

  def routes
    @@routes
  end

  def recognize(req_method, path)
    @@routes[req_method][path].split("#")
  end

end