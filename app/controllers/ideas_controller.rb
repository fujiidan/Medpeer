class IdeasController < ApplicationController

  def search
    category_name = params[:category_name]
    if category_name && Category.find_by(name: category_name)
      category_ideas = select_ideas.where(name: category_name)
      render json: { status: 200, message: "Ideas associated with categories", data: category_ideas}
    elsif category_name && !Category.find_by(name: category_name)
      render json: { status: 404, message: "Category not found" }
    else
      category_ideas = select_ideas
      render json: { status: 200, message: "All ideas", data: category_ideas }
    end  
  end
  
  def create
    idea_category = IdeaCategory.new(idea_params)
    if idea_category.valid?
      idea_category.save
      render json: { status: 201, message: "Created idea" }
    else
      render json: { status: 422, message: "Failed to create idea" }
    end  
  end

  private

  def idea_params
    params.require(:idea_category).permit(:name, :body)
  end

  def select_ideas
    Category.joins(:ideas).select('ideas.id, name AS category, body')
  end  
end
