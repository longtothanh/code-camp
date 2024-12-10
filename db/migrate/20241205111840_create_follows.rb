class CreateFollows < ActiveRecord::Migration[7.2]
  def change
    create_table :follows do |t|
      t.integer :follower_id, null: false, index: true
      t.integer :followed_id, null: false, index: true

      t.timestamps
    end
    add_index :follows, [:follower_id, :followed_id], unique: true
  end
end
