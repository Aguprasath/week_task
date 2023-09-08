class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: %i[show edit update destroy]
  load_and_authorize_resource
  # GET /comments or /comments.json
  def index
    @comments = @post.comments.eager_load(:user).all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = @post.comments.new
  end

  # GET /comments/1/edit
  def edit
    #authorize! :edit,@comment
  end

  # POST /comments or /comments.json
  def create
    @comment = @post.comments.new(comment_params)
    @comment.user=current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_post_comments_path(@post.topic,@post), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    #authorize! :update,@comment
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to topic_post_comments_path(@post.topic,@post), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    #authorize! :destroy,@comment
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to topic_post_comments_path(@post.topic,@post), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end
  def set_post
    @post=Post.find(params[:post_id])
  end
    # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
