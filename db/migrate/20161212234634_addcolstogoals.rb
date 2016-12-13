class Addcolstogoals < ActiveRecord::Migration
  def change
    add_column :goals, :visibility, :string, default: "Public"
    add_column :goals, :finished, :string, default: "Ongoing"
    add_column :goals, :cheers, :integer, default: 0
    add_column :users, :cheers_remaining, :integer, default: 12
  end
end
