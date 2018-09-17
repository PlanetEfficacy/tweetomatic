class Runner
  def self.run
    AutoReply.active.each do |auto_reply|
      bot = Bot.new(auto_reply)
      bot.find_tweets
      bot.reply_to_tweets
    end
  end
end
