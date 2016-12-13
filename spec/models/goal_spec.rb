# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  body       :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  visibility :string           default("Public")
#  finished   :string           default("Ongoing")
#  cheers     :integer          default("0")
#

require 'rails_helper'

RSpec.describe Goal, type: :model do
  subject(:goal) do
    FactoryGirl.build(:goal,
      title: "tunnel snakes rule!",
      body: "nfbsjkfnskj",
      user_id: (1 + rand(100))
      )
  end

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user) }

  it { should belong_to(:user) }
end
