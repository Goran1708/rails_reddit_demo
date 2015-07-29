class Comment < ActiveRecord::Base
  belongs_to :post
  validates :post_id, presence: true
  validates :content, presence: true
end
