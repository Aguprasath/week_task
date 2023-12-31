require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/comments", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Comment. As you add validations to Comment, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { content: "content about post"}
  }

  let(:invalid_attributes) {
    { content: ""}
  }
  let(:topic) { Topic.create(title: "The God", content: "content about gods") }
  let(:post) { topic.posts.create(title: "The God", content: "content about gods") }

  describe "GET /index" do
    it "renders a successful response" do
      post.comments.create! valid_attributes
      get topic_post_comments_path(post.topic,post)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      comment = post.comments.create! valid_attributes
      get topic_post_comment_path(topic,post,comment)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do

      get new_topic_post_comment_url(topic,post)
      expect(response).to render_template(:new)
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      comment = post.comments.create! valid_attributes
      get edit_topic_post_comment_url(topic,post,comment)
      expect(response).to be_successful
    end
  end

  describe "POST /comments" do
    context "with valid parameters" do
      it "creates a new Comment" do
        #expect {
          post topic_post_comments_path(:topic,:post), params: { comment: valid_attributes }
        expect(response).to be_successful
        #}.to be_successful
        #change(post.comments, :count).by(1)
      end

      it "redirects to the post after creating a new Comment" do
        post topic_post_comments_path(topic,post), params: { comment: valid_attributes }
        expect(response).to redirect_to(topic_post_path(topic,post))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Comment" do
        expect {
          post topic_post_comments_path(topic,post), params: { comment: invalid_attributes }
        }.not_to change(post.comments, :count)
      end

      it "renders a response with 422 status" do
        post topic_post_comments_path(topic,post), params: { comment: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end
  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {content: "updated content about post"}
      }

      it "updates the requested comment" do
        comment = post.comments.create! valid_attributes
        patch topic_post_comment_path(topic,post,comment), params: { comment: new_attributes }
        comment.reload
        #skip("Add assertions for updated state")
      end

      it "redirects to the comment" do
        comment = post.comments.create! valid_attributes
        patch topic_post_comment_path(topic,post,comment), params: { comment: new_attributes }
        comment.reload
        expect(response).to redirect_to(topic_post_comments_path(topic,post))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        comment = post.comments.create! valid_attributes
        patch topic_post_comment_path(topic,post,comment), params: { comment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested comment" do
      comment = post.comments.create! valid_attributes
      expect {
        delete topic_post_comment_path(topic,post,comment)
      }.to change(post.comments, :count).by(-1)
    end

    it "redirects to the comments list" do
      comment = post.comments.create! valid_attributes
      delete topic_post_comment_path(topic,post,comment)
      expect(response).to redirect_to(topic_post_comments_url)
    end
  end
end
