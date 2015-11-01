class Api::V1::CommentsController < Api::V1::ApiController
  
  def index
    expose Comment.all.paginate(page: params[:page], per_page: 20), 
                                          each_serializer: Api::V1::CommentSerializer
  end
  
  def show
    @post = Post.find(params[:post_id])
    expose @post.comments.find(params[:id]), serializer: Api::V1::CommentSerializer
  end
  
  def new 
    post = Post.find(params[:post_id])
    #2nd you build a new one
    @comment = post.comments.build
  end
  
  def create
    #1st you retrieve the post thanks to params[:post_id]
    post = Post.find(params[:post_id])
    #2nd you create the comment with arguments in params[:comment]
    @comment = post.comments.create(comments_params)
    
    #@post = Post.new(post_params)
    if @comment.save
      send_notification(post)
      redirect_to root_path
    else
      render :new
    end
  end
  
  def edit
    post = Post.find(params[:post_id])
    #2nd you retrieve the comment thanks to params[:id]
    @comment = post.comments.find(params[:id])
  end
  
  def update
    #1st you retrieve the post thanks to params[:post_id]
    post = Post.find(params[:post_id])
    #2nd you retrieve the comment thanks to params[:id]
    @comment = post.comments.find(params[:id])

    if @comment.update(comments_params)
      redirect_to root_path
    else
      render :edit
    end
  end
  
  def destroy
    #1st you retrieve the post thanks to params[:post_id]
    post = Post.find(params[:subreddit_id])
    #2nd you retrieve the comment thanks to params[:id]
    @comment = post.comments.find(params[:id])
    @comment.destroy
    
    redirect_to root_path
  end
  
  def comments_params
    params.require(:comment).permit(:post_id, :content)
  end
  
  def send_notification(post)
    @user = User.find_by! nickname: post.creator_name
    Notifications.comments(@user, @comment).deliver_now
  end
  
end
