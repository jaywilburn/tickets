require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { build(:user, type: User::TYPE.sample) }

  describe "Validations" do
    it { should validate_presence_of(:email) }
    it { should validate_inclusion_of(:type).in_array(User::TYPE) }
  end

  describe "#type_enum" do
    it "should return all available types" do
      expect(user.type_enum).to eq(["Admin", "SupportAgent", "Customer"])
    end
  end
end
