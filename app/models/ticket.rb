class Ticket < ApplicationRecord

  CATEGORY = %w(problem incident question task)
  PRIORITY = %w(urgent high normal low)
  STATUS = %w(pending hold solved closed)

  include RandomGenerator
  include Concerns::Ticket::Search

  # -- ASSOCIATIONS --

  belongs_to :requester, class_name: "Customer", foreign_key: "requester_id", optional: true

  belongs_to :assigned, class_name: "SupportAgent", foreign_key: "assigned_id", optional: true

  # -- DELEGATIONS --

  delegate :name, to: :requester, prefix: true, allow_nil: true

  delegate :name, to: :assigned, prefix: true, allow_nil: true

  # -- SCOPES --

  scope :by_subject_or_description_like, -> (value) { where("subject LIKE :value OR description LIKE :value", value: "%#{value}%") }

  scope :by_category, -> (value) { where(category: value)}

  scope :by_priority, -> (value) { where(priority: value)}

  scope :by_status, -> (value) { where(status: value)}

  scope :by_external_identifier, -> (value) { where(external_identifier: value)}

  scope :by_requester_id, -> (value) { where(requester_id: value)}

  scope :by_assigned_id, -> (value) { where(assigned_id: value)}

  scope :last_month, -> { where(created_at: DateTime.current.beginning_of_month..DateTime.current.end_of_month)  }

  # -- VALIDATIONS --

  # Category inclusion validation, allows blank
  validates :category, inclusion: { in: CATEGORY }, allow_blank: true

  # Priority inclusion validation, allows blank
  validates :priority, inclusion: { in: PRIORITY }, allow_blank: true

  # New status inclusion validation, allows blank and executes on update
  validates :status, inclusion: { in: STATUS }, allow_blank: true, on: :update

  # -- CALLBACKS --

  # Before create save external id
  before_create :save_external_identifier

  def category_enum
    CATEGORY
  end

  def priority_enum
    PRIORITY
  end

  def status_enum
    STATUS
  end

  class << self
    def export_as_pdf
      TicketsPdfExport.new(
        tickets: all,
        font: {
          bold: Rails.root.join('app/assets/fonts/roboto/Roboto-Bold.ttf'),
          normal: Rails.root.join('app/assets/fonts/roboto/Roboto-Regular.ttf')
        }
      )
    end
  end

  private

  # save_external_identifier
  # Description:
  # - Assigns a random url safe token to the external_identifier attribute
  def save_external_identifier
    self.external_identifier = generate_url_safe_random_token(:external_identifier)
  end

end
