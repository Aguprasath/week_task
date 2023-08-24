class PostsController < ApplicationController
  before_action :find_topic
  before_action :set_post, only: %i[show edit update destroy]
  load_and_authorize_resource
  # GET /topics/:topic_id/posts or /topics/:topic_id/posts.json
  def index
    if (params[:topic_id].present?)
      @posts = @topic.posts.page(params[:page]).per(3)
    else
      @posts=Post.page(params[:page]).per(3)
    end

  end

  # GET /posts/1 or /posts/1.json
  def show

    @rating = Rating.new
    @star_counts = @post.ratings.group(:star).count

  end

  # GET /topics/:topic_id/posts/new
  def new
    @post = @topic.posts.new
  end

  # GET /posts/1/edit
  def edit
    #authorize! :edit, @post
  end

  # POST /topics/:topic_id/posts or /topics/:topic_id/posts.json
  def create
    @post = @topic.posts.new(post_params)
    @post.user=current_user
    if params[:post][:tag_ids].present?
      @post.tags = Tag.where(id: params[:post][:tag_ids])
    end

    if params[:post][:tag_names].present?
      new_tags = params[:post][:tag_names].split(',').map(&:strip)
      new_tags.each { |tag_name| @post.tags << Tag.find_or_create_by(name: tag_name) }
    end

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
    #authorize! :update, @post
     @post.tags = Tag.where(id: params[:post][:tag_ids])
     if params[:post][:tag_ids].present?
       @post.tags = Tag.where(id: params[:post][:tag_ids])
     end

     if params[:post][:tag_names].present?
       new_tags = params[:post][:tag_names].split(',').map(&:strip)
       new_tags.each { |tag_name| @post.tags << Tag.find_or_create_by(name: tag_name) }
     end

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
    #authorize! :destroy,@post
    @post.destroy

    respond_to do |format|
      format.html { redirect_to topic_posts_url(@topic), notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def mark_as_read
    #if current_user.read_posts.exclude?(@post)
      current_user.read_posts << @post
    # end
    head :no_content

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = @topic.posts.find(params[:id])

  end

  def find_topic
    if (params[:topic_id].present?)
      @topic = Topic.find(params[:topic_id])
    end
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content,:image, tags_attributes:[:id,:name])
   end
end
