class Micropost < ApplicationRecord
  belongs_to :user
  has_many :users, through: :favorites, source: :user
    validates :user_id, presence: true
    validates :content, presence: true, length: { maximum: 50 }
end
