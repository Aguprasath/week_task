require 'rails_helper'

RSpec.describe PostsController,type: :controller do
  let(:topic) { Topic.create(title: "The God", content: "content about gods") }
  let(:tag){Tag.create(name: "tag name")}
  describe "POST #create" do
    context "with valid parameters" do
      it 'should Create a new post in topic' do
        post :create, params: {
          topic_id: topic.id,
          post: {
            title: "Post 1 about god",
            content: "content about post 1 of god",
            tag_ids: [tag_id: tag.id],
            tag_names: "tag1, tag2, tag3" # Comma-separated tag names
          }
        }
        # post :create, params: { topic_id: topic.id, post: { title: "Post 1 about god", content: " content about post 1 of god" } }
        expect(flash[:notice]).to eq("Post was successfully created.")
      end
      it "redirects to the show page of the created post" do
        post :create, params: { topic_id: topic.id, post: { title: "Post 1", content: "Post content" ,
                                                            tag_ids: [tag_id: tag.id],
                                                            tag_names: "tag1, tag2, tag3"} }
        expect(response).to redirect_to(topic_post_path(topic, assigns(:post)))
      end
    end
    context "with invalid parameters" do
      it  "should not allow user to add post with small post & content" do
        post :create, params: { topic_id: topic.id, post: { title: "", content: "" ,tag_ids: [tag_id: tag.id],
                                                            tag_names: "tag1, tag2, tag3"} }
        expect(flash[:notice]).to be_nil
      end
      it 'it should render new  ' do
        post :create, params: { topic_id: topic.id, post: { title: "", content: "",tag_ids: [tag_id: tag.id],
                                                            tag_names: "tag1, tag2, tag3" } }
        expect(response).to render_template(:new)
      end
    end
  end
  describe "GET #show" do

    it "assign requested post in posts of topic" do
      post=topic.posts.create(title: "Post 1", content: "Post content",tag_ids: [ tag.id])
      get :show, params: {topic_id:topic.id,id: post.id}
      expect(assigns(:post)).to eq(post)
    end
    it "renders the show template for post" do
      post=topic.posts.create(title: "Post 1", content: "Post content",tag_ids: [ tag.id])
      get :show, params: {topic_id: topic.id, id: post.id }
      expect(response).to render_template(:show)
    end
  end

  describe "PATCH #update" do
    # let(:post){topic.posts.create( params {topic_id: topic.id, post: { title: "Post 1", content: "Post content" ,
    # tag_ids: [tag_id: tag.id],
    #tag_names: "tag1, tag2, tag3"} })}
    let(:post) { topic.posts.create(title: "Post 1", content: "Post content") }

    it 'should update post ' do
      post.tags << [tag]
      patch :update, params: {topic_id: topic.id,id: post.id,post:{title:"updated content",content:"updated content",tag_names: "newtag"}}
      post.reload
      expect(post.title).to eq("updated content")
      expect(post.content).to eq("updated content")
      expect(post.tags.map(&:name)).to eq(["newtag"])
    end
    it "redirects to updated post" do
      patch :update, params: {topic_id: topic.id,id: post.id,post:{title:"updated content",content:"updated content",tag_names: "newtag"}}
      expect(response).to redirect_to(assigns(topic_post_path))
    end
  end

  describe "GET #edit" do
    it "assign requested post in posts of topic" do
      post=topic.posts.create(title: "Post 1", content: "Post content",tag_ids: [ tag.id])
      get :show, params: {topic_id:topic.id,id: post.id}
      expect(assigns(:post)).to eq(post)
    end
    it "renders the edit template for post" do
      post=topic.posts.create(title: "Post 1", content: "Post content",tag_ids: [ tag.id])
      get :edit, params: {topic_id: topic.id, id: post.id }
      expect(response).to render_template(:edit)
    end
  end
  describe "DELETE #destroy" do
    it "Deletes the requested post" do
      post=topic.posts.create(title: "Post 1", content: "Post content",tag_ids: [ tag.id])
      #post.tags<<[tag]
      expect{
        delete :destroy, params: {topic_id: topic.id, id: post.id}
      }.to change(topic.posts,:count).by(-1)
    end
    it "redirects to the posts index page" do
      post=topic.posts.create(title: "Post 1", content: "Post content",tag_ids: [ tag.id])
      delete :destroy,params: {topic_id: topic.id, id: post.id}
      expect(response).to redirect_to(topic_posts_path(topic))
    end
  end
end