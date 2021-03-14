class Category < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }
  has_many :ideas, dependent: :destroy

  def self.select_ideas
    Category.joins(:ideas).select('ideas.id, name AS category, body')
  end
end
