class Comment < ActiveRecord::Base
  belongs_to :post, dependent: :destroy, counter_cache: true
  belongs_to :user, dependent: :destroy
  
  validates :post_id, presence: true
  validates :content, presence: true
end
