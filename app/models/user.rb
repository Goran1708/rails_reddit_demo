class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :subreddit_subscriptions
  has_many :subreddits, through: :subreddit_subscriptions
  has_many :upvotes
  
  enum gender: [:male, :female]
  
  def subscribed_to?(subreddit)
    subreddit_subscriptions.where(subreddit_id: subreddit.id).exists?
  end
  
end
