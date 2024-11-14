class Movie < ApplicationRecord
  has_many: bookmark
  has_many: list :through bookmark
  validates :title, :overview, uniqueness: true
end
