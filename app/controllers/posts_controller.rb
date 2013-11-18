class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :set_post_redirect, only: [:show]
  http_basic_authenticate_with name: ENV["BLOG_USERNAME"], password: ENV["BLOG_PASSWORD"], 
                               only: [:edit, :update, :destroy, :new]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 1)
    @headlines = Post.all
  end

  def admin
    @posts = Post.paginate(:page => params[:page], :per_page => 5)
    @headlines = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @headlines = Post.all
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
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
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
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
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_redirect
      @post = Post.friendly.find(params[:id]) 
      # If an old id or a numeric id was used to find the record, then
      # the request path will not match the post_path, and we should do
      # a 301 redirect that uses the current friendly id.     
      if request.path != post_path(@post)
        redirect_to @post, status: :moved_permanently
      end
    end

    def set_post
      @post = Post.friendly.find(params[:id]) 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:headline, :slug, :intro, :article)
    end
end
