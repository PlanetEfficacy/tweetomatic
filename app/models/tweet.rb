class Tweet < ApplicationRecord
  validates :tweet_id, uniqueness: true, presence: true
  validates :user_id, presence: true
  validates :tweeted_at, presence: true

  def self.display_id_and_text(tweet)
    "tweet_id: #{tweet.id} text: #{tweet.text}"
  end

  def self.create_from_tweet(tweet)
    puts "creating tweet from #{Tweet.display_id_and_text(tweet)}"
    self.create(
      tweet_id: tweet.id,
      user_id: tweet.user.id,
      tweeted_at: tweet.created_at
    )
  end

  def self.unknown_tweet?(tweet)
    pluck(:tweet_id).exclude?(tweet.id)
  end
end
