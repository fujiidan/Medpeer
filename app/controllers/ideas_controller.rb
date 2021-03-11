class IdeasController < ApplicationController

  def search
    if params[:category_name]
      if Category.find_by(name: params[:category_name])
        @category_ideas = Category.joins(:ideas).where(name: params[:category_name]).select('ideas.id, name AS category, body')
        render json: { data: @category_ideas}
      else
        render json: { status: 404, message: "Category not found" }
      end  
    else
      @category_ideas = Category.joins(:ideas).select('ideas.id, name AS category, body')
      render json: { data: @category_ideas}
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
end
