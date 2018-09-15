class CreateAutoReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :auto_replies do |t|
      t.bigint :user_id
      t.string :text
      t.boolean :active

      t.timestamps
    end

    add_index :auto_replies, :user_id
  end
end
