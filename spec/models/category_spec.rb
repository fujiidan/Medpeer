require 'rails_helper'

RSpec.describe Category, type: :model do
  
  describe 'nameの一意性バリデーション確認' do
    
    it 'nameは一意性であること' do
      category = create(:category)
      another_category = build(:category, name: category.name)
      another_category.valid?
      expect(another_category.errors.full_messages).to include("Name has already been taken")
    end  
  end  
end
