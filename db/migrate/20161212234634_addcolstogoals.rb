class Addcolstogoals < ActiveRecord::Migration
  def change
    add_column :goals, :visibility, :boolean, default: false
    add_column :goals, :finished, :boolean, default: false
    add_column :goals, :cheers, :integer, default: 0
    add_column :users, :cheers_remaining, :integer, default: 12
  end
end
