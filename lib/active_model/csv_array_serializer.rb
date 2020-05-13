require 'csv'
require 'active_support/inflections'

module ActiveModel
  class CsvArraySerializer
    def initialize(objects, options = {})
      @each_serializer = options[:each_serializer]
      @objects = objects
      @options = options
    end

    def to_csv
      serializer = @each_serializer || ActiveModel::CsverizerFactory
      serializer = serializer.new(@objects.first, @options)
      options_hash = @options.slice(:serializer)

      CSV.generate do |csv|
        csv << serializer.attribute_names
        serializer = @each_serializer || ActiveModel::CsverizerFactory

        @objects.each do |record|
          serializer.new(record, options_hash).to_a.each { |record| csv << record }
        end
      end
    end
  end
end
