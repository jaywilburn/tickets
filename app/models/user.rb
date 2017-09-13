class User < ApplicationRecord

  TYPE = %w(Admin SupportAgent Customer)

  has_secure_password

  scope :by_lower_email, -> (email) { where("lower(email) = lower(:value)", { value: email }) }

  validates :email, presence: true, format: {with: /@/}
  validates :type, inclusion: { in: TYPE }, presence: true

  def type_enum
    TYPE
  end

end
