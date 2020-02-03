require 'spec_helper'

describe ActiveModel::CSVerizerFactory do
  let(:post) { Post.new(name: 'a', body: 'b') }

  describe '#new' do
    it 'builds a serializer with type based on singular association' do
      serializer = ActiveModel::CSVerizerFactory.new(post)
      expect(serializer).to be_a(PostCSVerizer)
    end

    it 'builds a serializer with type based on plural association' do
      serializer = ActiveModel::CSVerizerFactory.new(post)
      expect(serializer).to be_a(PostCSVerizer)
    end

    it 'raises name error when expected serializer not found' do
      expect do
        ActiveModel::CSVerizerFactory.new(Photo.new)
      end.to raise_error(NameError)
    end
  end
end
