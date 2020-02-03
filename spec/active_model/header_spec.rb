require 'spec_helper'

describe 'headers' do
  it 'includes headers based on attribute names by default' do
    post = Post.new(name: 'Samwise', body: 'Hobbit extraordinaire.')
    serializer = PostCSVerizer.new(post)
    csv = serializer.to_csv

    expect(csv).to include('name')
    expect(csv).to include('body')
  end

  context 'when root option set to false during serializer instantiation' do
    it 'does not include headers' do
      post = Post.new(name: 'Samwise', body: 'Hobbit extraordinaire.')
      serializer = PostCSVerizer.new(post, root: false)
      csv = serializer.to_csv

      expect(csv).to_not include('name')
      expect(csv).to_not include('body')
    end
  end

  context 'when root set to false during class definition' do
    before { PostCSVerizer.root = false }
    after { PostCSVerizer.root = true }

    it 'does not include headers' do
      post = Post.new(name: 'Samwise', body: 'Hobbit extraordinaire.')
      serializer = PostCSVerizer.new(post, root: false)
      csv = serializer.to_csv

      expect(csv).to_not include('name')
      expect(csv).to_not include('body')
    end
  end

  context 'when parent serializer root set to false' do
    before { ActiveModel::CSVerizer.root = false }
    after { ActiveModel::CSVerizer.root = true }

    it 'does not include headers' do
      post = Post.new(name: 'Samwise', body: 'Hobbit extraordinaire.')
      serializer = PostCSVerizer.new(post, root: false)
      csv = serializer.to_csv

      expect(csv).to_not include('name')
      expect(csv).to_not include('body')
    end
  end

  context 'when serialized object has one associated object' do
    it 'renders associated attributes prepended with its name' do
      category = Category.new(name: 'a')
      author = Author.new(name: 'b', category: category)
      serializer = AuthorCSVerizer.new(author)
      csv = serializer.to_csv

      expect(csv).to include('name')
      expect(csv).to include('category_name')
    end
  end

  context 'when serialized object has nested associated objects' do
    it 'renders associated attributes prepended with its objects name' do
      category = Category.new(name: 'a')
      author = Author.new(name: 'b', category: category)
      post = Post.new(name: 'a', body: 'b', author: author)
      serializer = PostCSVerizer.new(post)
      csv = serializer.to_csv

      expect(csv).to include('name')
      expect(csv).to include('body')
      expect(csv).to include('author_name')
      expect(csv).to include('category_name')
    end
  end

  context 'when serialized object has many associated objects' do
    it 'renders associated attributes prepended with its name' do
      comments = [
        Comment.new(text: 'c'),
        Comment.new(text: 'd'),
        Comment.new(text: 'e')
      ]
      post = Post.new(name: 'a', body: 'b', comments: comments)
      serializer = PostCSVerizer.new(post)
      csv = serializer.to_csv

      expect(csv).to include('name')
      expect(csv).to include('body')
      expect(csv).to include('comments_text') # TODO: singular prefix
      expect(csv.split("\n").length).to eq(4)
    end
  end
end
