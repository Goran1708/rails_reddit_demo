class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :content
  has_one :user, serializer: Api::V1::UserSerializer
end