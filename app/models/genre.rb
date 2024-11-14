class Genre < ApplicationRecord
  has_and_belongs_to_many :posts
  has_and_belongs_to_many :bands
end
