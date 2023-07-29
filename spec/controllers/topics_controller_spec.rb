require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new topic" do
        post :create, params: { topic: { title: "The Godfather", content: "Story of GOAT" } }
        expect(flash[:notice]).to eq("Topic was successfully created.")
      end

      it "redirects to the show page of the created topic" do
        post :create, params: { topic: { title: "The Godfather", content: "Story of GOAT" } }
        expect(response).to redirect_to(assigns(:topic))
      end


    end
    context "with Invalid parameters" do
      it "Does not a create a new topic" do
        post :create, params: { topic: { title: "", content: "" } }
        expect(flash[:notice]).to be_nil
      end
      it "render new template" do
        post :create, params: { topic: { title: "", content: "" } }
        expect(response).to render_template(:new)
      end
    end

  end
  describe "GET #show" do
    it "assigns the requested topic to @topic" do
      topic = Topic.create(title: "The Godfather", content: "Story of GOAT")
      get :show, params: { id: topic.id }
      expect(assigns(:topic)).to eq(topic)
    end

    it "renders the show template" do
      topic = Topic.create(title: "The Godfather", content: "Story of GOAT")
      get :show, params: { id: topic.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #edit" do
    it "assigns the requested topic to @topic" do
      topic = Topic.create(title: "The Godfather", content: "Story of GOAT")
      get :edit, params: { id: topic.id }
      expect(assigns(:topic)).to eq(topic)
    end

    it "renders the edit template" do
      topic = Topic.create(title: "The Godfather", content: "Story of GOAT")
      get :edit, params: { id: topic.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    it "updates the requested topic" do
      topic = Topic.create(title: "The Godfather", content: "Story of GOAT")
      patch :update, params: { id: topic.id, topic: { title: "Updated Title", content: "Updated Content" } }
      topic.reload
      expect(topic.title).to eq("Updated Title")
      expect(topic.content).to eq("Updated Content")
    end

    it "redirects to the updated topic" do
      topic = Topic.create(title: "The Godfather", content: "Story of GOAT")
      patch :update, params: { id: topic.id, topic: { title: "Updated Title", content: "Updated Content" } }
      expect(response).to redirect_to(assigns(:topic))
    end
  end

  describe "DELETE #destroy" do
    it "deletes the requested topic" do
      topic = Topic.create(title: "The Godfather", content: "Story of GOAT")
      expect {
        delete :destroy, params: { id: topic.id }
      }.to change(Topic, :count).by(-1)
    end

    it "redirects to the topics index page" do
      topic = Topic.create(title: "The Godfather", content: "Story of GOAT")
      delete :destroy, params: { id: topic.id }
      expect(response).to redirect_to(topics_path)
    end
  end
end
