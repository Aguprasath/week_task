require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:valid_attributes) {
    { content: "content about post"}
  }
  let(:topic) { Topic.create(title: "The God", content: "content about gods") }
  let(:post) { topic.posts.create(title: "The God", content: "content about gods") }
  it "Create comment belong to post" do
    comment = post.comments.create! valid_attributes
    expect(comment.post).to eq(post)
  end

end
