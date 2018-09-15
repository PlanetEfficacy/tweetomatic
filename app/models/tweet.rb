class Tweet < ApplicationRecord
  validates :tweet_id, uniqueness: true, presence: true
  validates :user_id, presence: true
  validates :tweeted_at, presence: true
end
