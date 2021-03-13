class Category < ApplicationRecord
  validates :name, uniqueness: true
  has_many :ideas

  def self.select_ideas
    Category.joins(:ideas).select('ideas.id, name AS category, body')
  end
end
