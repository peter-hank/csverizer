require 'spec_helper'

describe ActiveModel::CsverizerFactory do
  let(:post) { Post.new(name: 'a', body: 'b') }

  describe '#new' do
    it 'builds a serializer with type based on singular association' do
      serializer = ActiveModel::CsverizerFactory.new(post)
      expect(serializer).to be_a(PostCsverizer)
    end

    it 'builds a serializer with type based on plural association' do
      serializer = ActiveModel::CsverizerFactory.new(post)
      expect(serializer).to be_a(PostCsverizer)
    end

    it 'raises name error when expected serializer not found' do
      expect do
        ActiveModel::CsverizerFactory.new(Photo.new)
      end.to raise_error(NameError)
    end
  end
end
