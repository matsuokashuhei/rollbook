class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    if current_user.admin?
      @users = User.all.order(:name)
      @q = Post.search(params[:q])
      @posts = @q.result.order(open_date: :desc, updated_at: :desc)
    else
      @q = Post.search(params[:q])
      @posts = @q.result.where(user_id: current_user.id).order(open_date: :desc, updated_at: :desc)
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new user_id: current_user.id
  end

  # GET /posts/1/edit
  def edit
    redirect_to @post unless @post.editable?(current_user)
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    current_user.read_logs.build(post_id: @post.id, read_comments_count: 0)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'お知らせを登録しました。' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'お知らせを変更しました。' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    redirect_to @post unless @post.editable?(current_user)
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :open_date, :close_date)
    end

end
