class PostsController < ApplicationController
  before_action :find_topic, except: %i[index]
  before_action :set_post, only: %i[show edit update destroy]

  # GET /topics/:topic_id/posts or /topics/:topic_id/posts.json
  def index
    @topic = Topic.find(params[:topic_id]) # Load the topic for the index action
    @posts = @topic.posts.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /topics/:topic_id/posts/new
  def new
    @post = @topic.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /topics/:topic_id/posts or /topics/:topic_id/posts.json
  def create
    @post = @topic.posts.new(post_params) # Create the post associated with the topic

    respond_to do |format|
      if @post.save
        format.html { redirect_to topic_post_path(@topic, @post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to topic_post_path(@topic, @post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to topic_posts_url(@topic), notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def find_topic
    @topic = Topic.find(params[:topic_id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
