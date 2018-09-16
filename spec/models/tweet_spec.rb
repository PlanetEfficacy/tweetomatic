require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of(:tweet_id) }
    it { should validate_presence_of(:tweet_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:tweeted_at) }
  end

  describe 'factory' do
    it 'is valid' do
      expect(build :tweet).to be_valid
    end
  end

  describe '.display_id_and_text' do
    it 'outputs the correct string' do
      tweet = double
      allow(tweet).to receive(:id) { '12345' }
      allow(tweet).to receive(:text) { 'hello world' }
      expect(Tweet.display_id_and_text(tweet)).to eq 'tweet_id: 12345 text: hello world'
    end
  end

  describe '.create_from_tweet' do
    it 'creates a new tweet' do
      now = DateTime.now
      tweet = double
      user = double
      allow(tweet).to receive(:user) { user }
      allow(user).to receive(:id) { '12345' }
      allow(tweet).to receive(:id) { '67890' }
      allow(tweet).to receive(:created_at) { now }
      t = described_class.create_from_tweet(tweet)
      expect(t.attributes.with_indifferent_access).to include(
        tweet_id: 67890,
        user_id: 12345,
        tweeted_at: now
      )
    end
  end

  describe '.unknown_tweet?' do
    context 'when tweet is known' do
      let!(:tweet) { create :tweet }
      it 'returns true' do
        t = double
        allow(t).to receive(:id) { tweet.tweet_id }
        expect(described_class.unknown_tweet?(t)).to eq false
      end
    end

    context 'when tweet is unknown' do
      it 'returns true' do
        t = double
        allow(t).to receive(:id) { 12345 }
        expect(described_class.unknown_tweet?(t)).to eq true
      end
    end
  end
end
