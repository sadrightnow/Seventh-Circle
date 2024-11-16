class Post < ApplicationRecord
  validates :event_name, presence: true
  validates :event_date, presence: true
  has_many_attached :image
  has_many_attached :show_poster
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :bands

  validate :image_size, :show_poster_size

  private

  # Custom validation method to check file size for images
  def image_size
    if image.attached?
      image.each do |img|
        if img.byte_size > 5.megabytes
          errors.add(:image, "each file should be less than 5MB")
        end
      end
    end
  end

  # Custom validation method to check file size for show posters
  def show_poster_size
    if show_poster.attached?
      show_poster.each do |poster|
        if poster.byte_size > 5.megabytes
          errors.add(:show_poster, "each file should be less than 5MB")
        end
      end
    end
  end
end
