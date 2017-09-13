require 'rails_helper'

RSpec.describe SupportAgent, type: :model do
  describe "Associations" do
    it { should have_many(:assigned_tickets) }
  end
end
