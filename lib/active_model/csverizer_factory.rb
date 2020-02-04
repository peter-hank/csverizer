require 'active_support/inflections'

module ActiveModel
  module CsverizerFactory
    def self.new(object, options = {})
      return ActiveModel::Csverizer.new(nil) if object.nil?
      klass = object.model_name.name + 'Csverizer'
      klass.constantize.new(object, options)
    end
  end
end
