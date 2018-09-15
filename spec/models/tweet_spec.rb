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
end
