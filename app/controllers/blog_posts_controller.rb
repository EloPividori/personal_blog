class BlogPostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]

  def index
    @blog_posts = user_signed_in? ? BlogPost.ordered : BlogPost.published.ordered
    @blog_post = BlogPost.new
  end

  def show
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)

    if @blog_post.save
      respond_to do |format|
        format.html { redirect_to blog_posts_path, notice: 'Blog post was successfully created.' }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to blog_posts_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy

    respond_to do |format|
      format.html { redirect_to blog_posts_path, notice: 'Blog post was successfully destroyed.' }
      format.turbo_stream
    end
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :published_at )
  end

  def set_blog_post
    @blog_post = user_signed_in? ? BlogPost.find(params[:id]) : BlogPost.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
