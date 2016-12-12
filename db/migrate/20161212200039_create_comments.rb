class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body, null: false
      t.integer :user_id, null: false, index: true
      t.integer :goal_id, null: false, index: true

      t.timestamps null: false
    end
  end
end
