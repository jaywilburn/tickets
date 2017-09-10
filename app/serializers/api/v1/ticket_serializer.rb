class Api::V1::TicketSerializer < ActiveModel::Serializer

  attributes :subject, :description, :category, :priority, :status,
    :external_identifier, :requester_id, :assignee_id, :created_at, :updated_at

  belongs_to :requester, serializer: Api::V1::UserSerializer
  belongs_to :assignee, serializer: Api::V1::UserSerializer
end
