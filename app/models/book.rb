class Book < ApplicationRecord
  has_one_attached :content
end
