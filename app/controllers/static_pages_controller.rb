class StaticPagesController < ApplicationController
  
  def index
    @posts = Post.where(subreddit: current_user.subreddits).recent
  end
  
  def frontpage
    @posts = Post.where(subreddit: current_user.subreddits).recent
    @posts = @posts.includes(:subreddit).paginate(page: params[:page], per_page: 20)
  end
  
end