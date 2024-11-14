class Band < ApplicationRecord
  has_one_attached :profile_picture
  has_and_belongs_to_many :posts
  has_many :shows # Assuming shows are associated with bands
  has_and_belongs_to_many :genres
end
