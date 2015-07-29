class SubredditsController < ApplicationController
  
  def index
    @subreddits = Subreddit.all
  end
  
  def show
    @subreddit = Subreddit.find(params[:id])
  end
  
  def new 
    @subreddit = Subreddit.new
  end
  
  def create
    @subreddit = Subreddit.new(subreddit_params)
    if @subreddit.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  def subreddit_params
    params.require(:subreddit).permit(:name, :description)
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
end
