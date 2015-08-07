class Subreddit < ActiveRecord::Base
  include RocketPants::Cacheable
  
  has_many :posts
  has_many :subreddit_subscriptions
  has_many :users, through: :subreddit_subscriptions
  
  validates :name, presence: true, length: { minimum: 3, maximum: 20 }, :uniqueness => true
  validates :description, length: { maximum: 500 }
  
  scope :recent, -> { order(updated_at: :desc) }
end
