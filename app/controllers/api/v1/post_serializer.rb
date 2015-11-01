class Api::V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :comments_count, :upvotes_count
  has_many :comments, serializer: Api::V1::CommentSerializer
  has_one :user, serializer: Api::V1::UserSerializer
end