require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let(:customer) { create(:customer) }
  let(:support_agent) { create(:support_agent) }
  let(:ticket) { create(:ticket, requester: customer, assigned: support_agent) }

  describe "Validations" do
    it { should validate_inclusion_of(:category).in_array(Ticket::CATEGORY) }
    it { should validate_inclusion_of(:priority).in_array(Ticket::PRIORITY) }
    it { should validate_inclusion_of(:status).in_array(Ticket::STATUS).on(:update) }
  end

  describe "Associations" do
    it { should belong_to(:requester) }
    it { should belong_to(:assigned) }
  end

  describe "Delegations" do
    it { should delegate_method(:name).to(:requester).with_prefix }
    it { should delegate_method(:name).to(:assigned).with_prefix }
  end

  describe "Callbacks" do
    it { is_expected.to callback(:save_external_identifier).before(:create) }
  end
end
