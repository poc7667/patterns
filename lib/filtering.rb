require 'active_support/concern'
require 'active_support/callbacks'

module Filtering
  extend ActiveSupport::Concern
  include ActiveSupport::Callbacks
  extend ActiveSupport::Callbacks

  # because ActiveSupport::Concern will do the include/extend tricks for you
  # def self.included(base) # base == ActionController::Base
  #   base.extend ClassMethods
  # end

  included do
    define_callbacks :process
  end

  module ClassMethods

    def before_action(method)
      set_callback :process, :before, method
    end

    def after_action(method)
      set_callback :process, :after, method
    end

    # def after_actions
    #   @after_actions ||= []
    # end
  end

  def process(action_name)
    run_callbacks :process do
      super
    end

    # self.class.before_actions.each { |method| send method }
    # super
    # self.class.after_actions.each {|method| send method }
  end
end