# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  username         :string           not null
#  session_token    :string           not null
#  password_digest  :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  cheers_remaining :integer          default("12")
#

require 'rails_helper'

RSpec.describe User, type: :model do
    subject(:user) do
      FactoryGirl.build(:user,
        username: "Boris",
        password: "password")
    end

    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }

    it { should have_many(:goals) }
    it { should have_many(:comments) }

    it "creates password digest when password is given" do
      expect(user.password_digest).to_not be_nil
    end

    it "creates a session token before validation" do
      user.valid?
      expect(user.session_token).to_not be_nil
    end


    describe "#is_password?" do
      it "verifies password is correct" do
        expect(user.is_password?("password")).to be true
      end

      it "verifies a password is not correct" do
        expect(user.is_password?("blahblahblah")).to be false
      end
    end

    describe "#restore_session_token!" do
      it "restores the user's session token" do
        user.valid?
        old_session_token = user.session_token
        user.restore_session_token!
        expect(old_session_token).to_not eq(user.session_token)
      end

      it "returns the new session_token" do
        expect(user.restore_session_token!).to eq(user.session_token)
      end
    end


    describe ".find_by_credentials" do
      before { user.save! }

      it "returns user given good credentials" do
        expect(User.find_by_credentials("Boris", "password")).to eq(user)
      end

      it "returns nil given bad credentials" do
        expect(User.find_by_credentials("Boris", "badpassword")).to eq(nil)
      end
    end

end
