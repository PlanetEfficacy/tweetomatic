class Bot < Chatterbot::Bot
  attr_reader :auto_reply,
              :tweets

  def initialize(auto_reply)
    @auto_reply = auto_reply
    @tweets = []
  end

  delegate :user_id, :text, to: :auto_reply

  def find_tweets
    puts "finding tweets from #{screen_name}."
    search "from:#{screen_name}" do |tweet|
      if Tweet.unknown_tweet?(tweet) && !tweet.reply? && !tweet.retweet?
        puts "New, non reply tweet:#{tweet.id} - #{tweet.text}"
        tweets << tweet
      end
    end
  end

  def reply_to_tweets
    puts "replying to #{tweets.count} tweets..."
    tweets.each do |tweet|
      if Tweet.create_from_tweet(tweet)
        Rails.logger.info "Replying to #{Tweet.display_id_and_text(tweet)} with status: #{status}"
        puts "#{Tweet.display_id_and_text(tweet)} created. Tweet count is now #{Tweet.count}"
        reply_tweet = reply(status, tweet)
        puts "Replied - #{Tweet.display_id_and_text(reply_tweet)}"
      else
        Rails.logger.warn "Could not save tweet_id: #{Tweet.display_id_and_text(tweet)}"
      end
    end
  end

  def screen_name
    @screen_name ||= client.user(user_id).screen_name
  end

  def status
    "@#{screen_name} - #{text}"
  end

  def notify(reply_tweet, tweet)
    direct_message "Master, your will be done - #{Tweet.display_id_and_text(tweet)}", reply_tweet.user
  end
end
