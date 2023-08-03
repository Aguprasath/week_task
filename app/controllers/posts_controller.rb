class PostsController < ApplicationController
  before_action :find_topic
  before_action :set_post, only: %i[show edit update destroy]

  # GET /topics/:topic_id/posts or /topics/:topic_id/posts.json
  def index
    if (params[:topic_id].present?)
      @posts = @topic.posts.all
    else
      @posts=Post.all
    end
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
    @post = @topic.posts.new(post_params)
    @post.tags << Tag.where(id: params[:post][:tag_ids])
    new_tags = params[:post][:tag_names].split(',').map(&:strip)
    new_tags.each { |tag_name| @post.tags << Tag.find_or_create_by(name: tag_name) }


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
    @post.tags = Tag.where(id: params[:post][:tag_ids])
    new_tags = params[:post][:tag_names].split(',').map(&:strip)
    new_tags.each { |tag_name| @post.tags << Tag.find_or_create_by(name: tag_name) }
    #new_tags.each { |tag_name| @post.tags << ( tag_name) }

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
    if (params[:topic_id].present?)
      @topic = Topic.find(params[:topic_id])
    end
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content,tag_ids: [])
  end
end
