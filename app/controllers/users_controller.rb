require 'active_record'
require 'user'

class UsersController < ApplicationController
  def index
    User.all.each do |user|
      response.write user.name+"\n"
    end
  end
end