class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.bigint :tweet_id
      t.datetime :tweeted_at
      t.bigint :user_id

      t.timestamps
    end

    add_index :tweets, :user_id
  end
end
