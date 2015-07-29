class SubredditSubscriptionsController < ApplicationController
  
  def create
    @subreddit = Subreddit.find(params[:subreddit_id])
    SubredditSubscription.create(user: current_user, subreddit: @subreddit)

    respond_to do |format|
      format.html { redirect_to subreddit_path(@subreddit) }
      format.js { render :subscription_button }
    end
  end

  def destroy
    @subreddit = Subreddit.find(params[:subreddit_id])
    SubredditSubscription.where(user: current_user, subreddit: @subreddit).destroy_all

    respond_to do |format|
      format.html { redirect_to subreddit_path(@subreddit) }
      format.js { render :subscription_button }
    end
  end
  
end
