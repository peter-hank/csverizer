# CSVerizer

`ActiveModel::Serializers` style CSV serialization.

## Installation

Add this line to your application's Gemfile:

    gem 'csverizer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csverizer

## Usage

```ruby
class Post
  include ActiveModel::Serialization
  attr_accessor :title, :body
  def attributes; end # not necessary for ActiveModel::CSVerizer
end

class PostSerializer < ActiveModel::CSVerizer
  attributes :title, :body
end
```

```ruby
post = Post.new(title: 'Welcome', body: 'Why hello there!')
PostSerializer.new(post).to_csv   # => "title,body\nWelcome,Why hello there!"
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/active_model_csv_serializers/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
