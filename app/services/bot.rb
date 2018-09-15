class Bot < Chatterbot::Bot
  attr_reader :user_id,
              :tweets

  def initialize(user_id)
    @user_id = user_id
    @tweets = []
  end

  def find_tweets
    search "from:#{screen_name}" do |tweet|
      unless tweet.reply?
        tweets << tweet
      end
    end
  end



  def screen_name
    @screen_name ||= client.user(user_id).screen_name
  end
end
