class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_create :set_auth_token
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :subreddit_subscriptions
  has_many :subreddits, through: :subreddit_subscriptions
  has_many :upvotes
  
  enum gender: [:male, :female]
  
  def subscribed_to?(subreddit)
    subreddit_subscriptions.where(subreddit_id: subreddit.id).exists?
  end
  
  private
    def set_auth_token
      return if token.present?
      self.token = generate_token
    end
  
    def generate_token
      SecureRandom.uuid.gsub(/\-/,'')
    end
end
