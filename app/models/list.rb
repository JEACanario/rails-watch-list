class List < ApplicationRecord
  has_many :bookmarks
  has_many :movies, :uniq through: :bookmarks
end
