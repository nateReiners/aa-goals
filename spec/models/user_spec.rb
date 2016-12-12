require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do
    subject(:user) do
      FactoryGirl.build(:user,
        username: "Boris",
        password: "password" )
    end

    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6) }

    it { should have_many(:goals) }
    it { should have_many(:comments) }

    descibe ".find_by_credentials" do
      before { user.save! }

      it "returns user given good credentials" do
        expect(User.find_by_credentials("Boris", "password")).to eq(user)
      end

      it "returns nil given bad credentials" do
        expect(User.find_by_credentials("Boris", "badpassword")).to eq(nil)
      end 
    end

  end
end
