require 'rails_helper'

RSpec.describe PostsController,type: :controller do
  describe "POST #create" do
    context "with valid parameters" do
      let(:topic) { Topic.create(title: "The God", content: "content about gods") }
      it 'should Create a new post in topic' do
        post :create, params: { topic_id: topic.id, post: { title: "Post 1 about god", content: " content about post 1 of god" } }
        expect(flash[:notice]).to eq("Post was successfully created.")
      end
      it "redirects to the show page of the created post" do
        post :create, params: { topic_id: topic.id, post: { title: "Post 1", content: "Post content" } }
        expect(response).to redirect_to(topic_post_path(topic, assigns(:post)))
      end
    end
    context "with invalid parameters" do
      let(:topic) { Topic.create(title: "The God", content: "content about gods") }
      it  "should not allow user to add post with small post & content" do
        post :create, params: { topic_id: topic.id, post: { title: "", content: "" } }
        expect(flash[:notice]).to be_nil
      end
      it 'it should render new  ' do
        post :create, params: { topic_id: topic.id, post: { title: "", content: "" } }
        expect(response).to render_template(:new)
      end
    end
  end
  describe "GET #show" do

      let(:topic) { Topic.create(title: "The God", content: "content about gods") }
      it "assign requested post in posts of topic" do
        post=topic.posts.create(title: "Post 1", content: "Post content")
        get :show, params: {topic_id:topic.id,id: post.id}
        expect(assigns(:post)).to eq(post)
      end
      it "renders the show template for post" do
        post=topic.posts.create(title: "Post 1", content: "Post content")
        get :show, params: {topic_id: topic.id, id: post.id }
        expect(response).to render_template(:show)
      end
    end

  describe "PATCH #update" do
     let(:topic) { Topic.create(title: "The God", content: "content about gods") }
      let(:post){topic.posts.create(title: "Post 1", content: "Post content")}
      it 'should update post ' do
       patch :update, params: {topic_id: topic.id,id: post.id,post:{title:"updated content",content:"updated content"}}
       post.reload
       expect(post.title).to eq("updated content")
       expect(post.content).to eq("updated content")
      end
      it "redirects to updated post" do
        patch :update, params: {topic_id: topic.id,id: post.id,post:{title:"updated content",content:"updated content"}}
        expect(response).to redirect_to(assigns(topic_post_path))
      end
    end

  describe "GET #edit" do
    let(:topic) { Topic.create(title: "The God", content: "content about gods") }
    it "assign requested post in posts of topic" do
      post=topic.posts.create(title: "Post 1", content: "Post content")
      get :show, params: {topic_id:topic.id,id: post.id}
      expect(assigns(:post)).to eq(post)
    end
    it "renders the edit template for post" do
      post=topic.posts.create(title: "Post 1", content: "Post content")
      get :edit, params: {topic_id: topic.id, id: post.id }
      expect(response).to render_template(:edit)
    end
  end
  describe "DELETE #destroy" do
    let(:topic) { Topic.create(title: "The God", content: "content about gods") }
    it "Deletes the requested post" do
      post=topic.posts.create(title: "Post 1", content: "Post content")
      expect{
        delete :destroy, params: {topic_id: topic.id, id: post.id}
      }.to change(topic.posts,:count).by(-1)
    end
    it "redirects to the posts index page" do
      post=topic.posts.create(title: "Post 1", content: "Post content")
      delete :destroy,params: {topic_id: topic.id, id: post.id}
      expect(response).to redirect_to(topic_posts_path(topic))
    end
  end
end