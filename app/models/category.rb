class Category < ApplicationRecord
  validates :name, uniquness: true
  has_many :ideas
end
