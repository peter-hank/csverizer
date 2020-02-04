require 'spec_helper'

describe 'has_many' do
  let(:post) { Post.new(name: 'a', body: 'b', comments: comments) }
  let(:comments) do
    [
      Comment.new(text: 'c'),
      Comment.new(text: 'd'),
      Comment.new(text: 'e')
    ]
  end
  let(:serializer) { PostCsverizer.new(post, root: false) }

  it 'appends associated objects csv to multiple copies of this' do
    csv = serializer.to_csv
    records = csv.split("\n")
    expect(records.length).to eq(comments.length)
    records.each.with_index do |record, i|
      next if i == 0
      expect(record).to include(post.name)
      expect(record).to include(post.body)

      comment = comments[i]
      expect(record).to include(comment.text)
    end
  end
end
