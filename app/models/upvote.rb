class Upvote < ActiveRecord::Base
  belongs_to :post, dependent: :destroy, counter_cache: true
  belongs_to :user, dependent: :destroy
end
