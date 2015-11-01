class Api::V1::SubredditSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :excerpt, :recent_posts
  has_many :posts, serializer: Api::V1::PostSerializer
  
  def excerpt
    object.description.truncate(20)
  end
  
  def recent_posts
    object.posts.limit(3).reverse
  end
end