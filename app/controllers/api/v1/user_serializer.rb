class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :nickname, :gender, :token
  
  def gender
    if object.gender.eql? 1
      "male"
    else
      "female"
    end
  end
end