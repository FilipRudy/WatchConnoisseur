class Watch < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 150 }
  validates :description, presence: true, length: { minimum: 5, maximum: 250 }
  validates :category, presence: true
  validates :price, presence: true
  validates :photo_url, presence: true
  validates :user_id, presence: true

  belongs_to :user
  enum category: { standard: 0, premium: 1, premium_plus: 2 }
end

