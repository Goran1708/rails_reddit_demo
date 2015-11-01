class Api::V1::SubredditsController < Api::V1::ApiController
  
  def index
    expose Subreddit.all.paginate(page: params[:page], per_page: 20), each_serializer: Api::V1::SubredditSerializer
  end
  
  def show
    expose Subreddit.find(params[:id]), serializer: Api::V1::SubredditSerializer
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
