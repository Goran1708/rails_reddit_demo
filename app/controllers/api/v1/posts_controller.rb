class Api::V1::PostsController < Api::V1::ApiController
  before_action :load_subreddit
  
  def index
    expose Post.all.paginate(page: params[:page], per_page: 20), each_serializer: 
                                                        Api::V1::PostSerializer
  end
  
  def show
    @subreddit = Subreddit.find(params[:subreddit_id])
    expose @subreddit.posts.find(params[:id]), serializer: Api::V1::PostSerializer
  end
  
  def new 
    subreddit = Subreddit.find(params[:subreddit_id])
    #2nd you build a new one
    @post = subreddit.posts.build
    #@post = Post.new
  end
  
  def create
    #1st you retrieve the post thanks to params[:post_id]
    subreddit = Subreddit.find(params[:subreddit_id])
    #2nd you create the comment with arguments in params[:comment]
    @post = subreddit.posts.create(post_params)
    
    #@post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  def edit
    subreddit = Subreddit.find(params[:subreddit_id])
    #2nd you retrieve the comment thanks to params[:id]
    @post = subreddit.posts.find(params[:id])
  end
  
  def update
    #1st you retrieve the post thanks to params[:post_id]
    subreddit = Subreddit.find(params[:subreddit_id])
    #2nd you retrieve the comment thanks to params[:id]
    @post = subreddit.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to root_path
    else
      render :edit
    end
  end
  
  def destroy
    #1st you retrieve the post thanks to params[:post_id]
    subreddit = Subreddit.find(params[:subreddit_id])
    #2nd you retrieve the comment thanks to params[:id]
    @post = subreddit.posts.find(params[:id])
    @post.destroy
    
    redirect_to root_path
  end
  
  def upvote
    @post = @subreddit.posts.find(params[:post_id])
    Upvote.find_or_create_by(user: current_user, post: @post)
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { }
    end
  end
  
  private

  def load_subreddit
    @subreddit = Subreddit.find(params[:subreddit_id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
  
end
