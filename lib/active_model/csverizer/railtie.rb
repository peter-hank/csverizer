class ActiveModel::Csverizer::Railtie < Rails::Railtie
  initializer 'csverizer' do
    ActiveSupport.on_load(:action_controller) do
      ActionController::Renderers.add :csv do |object, options|
        filename = options.fetch(:filename, 'data')
        begin
          serializer =
            if object.respond_to?(:each)
              hash = options.slice(:each_serializer)
              ActiveModel::CsvArraySerializer.new(object, hash)
            else
              hash = options.slice(:serializer)
              ActiveModel::CsverizerFactory.new(object, hash)
            end
          data = serializer.to_csv
        # TODO: probably should implement a specialized exception for this
        #   this btw is when a serializer is not found for provided object
        rescue NameError
          data = object.respond_to?(:to_csv) ? object.to_csv : object.to_s
        end
        send_data(
          data,
          type: Mime[:csv],
          disposition: "attachment; filename=#{filename}.csv"
        )
      end
    end
  end
end
