class HomeController < ApplicationController
  before_action :header
  after_action :footer

  def index
    @message = "Hi Poc, I'm from HomeController"
    render :index
  end

  def header
    response.write "<h1>My App</h1>"
  end

  def footer
    response.write "&copy; me"
  end
end