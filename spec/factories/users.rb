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

FactoryGirl.define do
  factory :user do
    
  end
end
