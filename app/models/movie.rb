class Movie < ApplicationRecord
  has_many :bookmarks

  has_many :lists, :uniq through: :bookmarks
  validates :title, :overview, uniqueness: true
end
