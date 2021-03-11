class IdeaCategory

  include ActiveModel::Model
  attr_accessor :body, :name

  with_options presence: true do
    validates :body
    validates :name, length: { maximum: 255 }
  end

  # def to_model
  #   idea
  # end  

  def save
    category = Category.find_or_create_by(name: name)
    Idea.create(body: body, category_id: category.id)
  end
end  