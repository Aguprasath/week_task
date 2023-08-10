require 'rails_helper'

RSpec.describe Post,type: :model do
  let(:topic){Topic.create(title: "Topic for Association",content: "content about association")}
  it "Creates post belong to topic" do
    post=topic.posts.create(title: "post 1",content: "content of post 1")
    expect(post.topic).to eq(topic)
  end
   describe 'image attachment' do
      it 'attaches an image' do
        post=topic.posts.create(title: "post 1",content: "content of post 1")
        image_path = Rails.root.join('C:\Users\AGUPRASATH\OneDrive\Pictures\Screenshots\Screenshot_20230221_065359.png')
        post.image.attach(io: File.open(image_path), filename: 'Screenshot_20230221_065359.png', content_type: 'image/png')

        expect(post.image).to be_attached
      end
   end
end