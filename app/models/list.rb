class List < ApplicationRecord
  has_many: bookmark
  has_many: movie :through bookmark
end
