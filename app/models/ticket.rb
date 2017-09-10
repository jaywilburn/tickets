class Ticket < ApplicationRecord

  CATEGORY = %w(problem incident question task)
  PRIORITY = %w(urgent high normal low)
  STATUS = %w(pending hold solved closed)

  # AASM - State machines for Ruby classes (plain Ruby, ActiveRecord, Mongoid)
  # https://github.com/aasm/aasm
  include AASM
  include RandomGenerator

  attr_accessor :new_status

  # AASM setup:
  # - Default status is open
  # - Can transition to pending if status is: open, solved or hold
  # - Can transition to hold if status is: open, pending or solved
  # - Can transition to solved if status is: open, pending or hold
  # - Can transition to closed if status is: solved
  aasm column: :status do
    state :open, initial: true
    state :pending, :hold, :solved, :closed

    event :mark_as_pending do
      transitions from: [:open, :solved, :hold], to: :pending
    end

    event :mark_as_hold do
      transitions from: [:open, :pending, :solved], to: :hold
    end

    event :mark_as_solved do
      transitions from: [:open, :pending, :hold], to: :solved
    end

    event :mark_as_closed do
      transitions from: [:solved], to: :closed
    end
  end

  # -- ASSOCIATIONS --

  belongs_to :requester, class_name: "Customer", foreign_key: "requester_id", optional: true

  belongs_to :assignee, class_name: "SupportAgent", foreign_key: "assignee_id", optional: true

  # -- SCOPES --

  scope :subject_or_description_like, -> (value) { where("subject ILIKE :value OR description ILIKE :value", value: "%#{value}%") }

  scope :by_category, -> (value) { where(category: value)}

  scope :by_priority, -> (value) { where(priority: value)}

  scope :by_status, -> (value) { where(status: value)}

  scope :by_external_identifier, -> (value) { where(external_identifier: value)}

  scope :by_requester_id, -> (value) { where(requester_id: value)}

  scope :by_assignee_id, -> (value) { where(assignee_id: value)}

  # -- VALIDATIONS --

  # Category inclusion validation, allows blank
  validates :category, inclusion: { in: CATEGORY }, allow_blank: true

  # Priority inclusion validation, allows blank
  validates :priority, inclusion: { in: PRIORITY }, allow_blank: true

  # New status inclusion validation, allows blank and executes on update
  validates :new_status, inclusion: { in: STATUS }, allow_blank: true, on: :update

  # -- CALLBACKS --

  # Before update save new status if there is new status
  before_update :save_new_status, if: :new_status

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

  private

  # save_new_status
  # Description:
  # - Fires AASM state
  # - Captures exception if can't transition
  #   from one state to a new one and halt callbacks
  def save_new_status
    begin
      send("mark_as_#{new_status}".to_sym)
    rescue => e
      self.errors.add(:new_status, "can't transition from #{status}")
      throw(:abort)
    end
  end

  # save_external_identifier
  # Description:
  # - Assigns a random url safe token to the external_identifier attribute
  def save_external_identifier
    self.external_identifier = generate_url_safe_random_token(:external_identifier)
  end

end
