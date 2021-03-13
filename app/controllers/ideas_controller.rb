class IdeasController < ApplicationController

  def search
    category_name = params[:category_name]
    if category_name.present? && Category.find_by(name: category_name)
      category_ideas = select_ideas.where(name: category_name)
      render status: 200, json: { status: 200, message: "Idea Search OK", data: category_ideas}
    elsif category_name.present? && !Category.find_by(name: category_name)
      render status: 404, json: { status: 404, message: "Category Not Found" }
    else
      category_ideas = select_ideas
      render status: 200, json: { status: 200, message: "OK", data: category_ideas }
    end
  end
  
  def create
    idea_category = IdeaCategory.new(idea_params)
    if idea_category.save
      render status: 201, json: { status: 201, message: "Created Idea" }
    else
      render status: 422, json: { status: 422, message: "Unprocessable Entity" }
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
