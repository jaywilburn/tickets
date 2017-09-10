class Api::V1::UserSerializer < ActiveModel::Serializer

  attributes :id, :name, :email, :type, :created_at, :updated_at

end
