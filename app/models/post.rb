class Post < ActiveRecord::Base
  belongs_to :subreddit
  has_many :comments
  has_many :upvotes
  
  validates :subreddit_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  
  scope :recent, -> { order(updated_at: :desc) }
end
