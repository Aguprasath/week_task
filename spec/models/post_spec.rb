require 'rails_helper'

RSpec.describe Post,type: :model do
  let(:topic){Topic.create(title: "Topic for Association",content: "content about association")}
  it "Creates post belong to model" do
    post=topic.posts.create(title: "post 1",content: "content of post 1")
    expect(post.topic).to eq(topic)
  end
end