# Start with: shotgun
# Under Windows: rackup  (CTRL+C and restart on each change)
require 'pry'


# rakeup version
# class App
#   def call(env)
#     # Return the response array here
#     [

#     ]
#   end
# end
# run App.new


Routes = {
  "GET" => {

  }
}

def get(path, &block)
  Routes["GET"][path] = block
end

get "/" do
  "poc awesome!!"
end

run -> env  do
  method = env["REQUEST_METHOD"]
  path = env["PATH_INFO"]
  # binding.pry
  if block = Routes[method][path]
    body = block.call
    [200, {}, [body]]
  else
    [404, {}, ["not found"]]
  end
end