require 'active_support/inflections'

module ActiveModel
  module CSVerizerFactory
    def self.new(object, options = {})
      return ActiveModel::CSVerizer.new(nil) if object.nil?
      klass = object.model_name.name + 'CSVerizer'
      klass.constantize.new(object, options)
    end
  end
end
