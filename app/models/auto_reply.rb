class AutoReply < ApplicationRecord
  validates :user_id, uniqueness: true, presence: true
  validates :text, presence: true

  scope :active, -> { where(active: true) }
end
