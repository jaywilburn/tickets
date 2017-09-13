class Api::V1::TicketSerializer < ActiveModel::Serializer

  attributes :subject, :description, :category, :priority, :status,
    :external_identifier, :requester_id, :assigned_id,
    :requester_name, :assigned_name, :created_at, :updated_at

  belongs_to :requester, serializer: Api::V1::UserSerializer
  belongs_to :assigned, serializer: Api::V1::UserSerializer
end
