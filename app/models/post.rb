class Post < ApplicationRecord
  validates :event_name, presence: true
  validates :event_date, presence: true
  has_many_attached :image
  has_many_attached :show_poster
  has_and_belongs_to_many :bands
end
