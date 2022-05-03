# frozen_string_literal: true

# holds all the helpers that can be accessed application wide
module ApplicationHelper
  def extract_data(record, methods)
    methods = methods.split('.')
    methods.inject(record) { |object, method| object.send(:try, method) }
  end
end
