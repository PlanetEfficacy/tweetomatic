require 'rails_helper'

RSpec.describe AutoReply, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of(:user_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:text) }
  end

  describe 'factory' do
    it 'is valid' do
      expect(build :auto_reply).to be_valid
    end
  end

  describe '.active' do
    it 'returns active auto replies' do
      auto_reply = create :auto_reply
      create :auto_reply, user_id: '12345', active: false

      expect(described_class.active).to eq described_class.where(active: true)
    end
  end
end
