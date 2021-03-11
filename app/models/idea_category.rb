class IdeaCategory

  include ActiveModel::Model
  attr_accessor :body, :name

  with_options presence: true do
    validates :body
    validates :name, length: { maximum: 255 }
  end

  def save
    return if invalid?
    ActiveRecord::Base.transaction do
      category = Category.find_or_create_by!(name: name)
      Idea.create!(body: body, category_id: category.id)
    end
    rescue ActiveRecord::RecordInvalid
      false
  end
end  