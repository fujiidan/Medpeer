require 'rails_helper'

RSpec.describe IdeaCategory, type: :model do
  before do
    @idea_category = build(:idea_category)
  end

  describe 'idea,category登録' do
    context 'idea,category登録できるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@idea_category).to be_valid
      end
    end

    context 'idea,category登録できないとき' do
      it 'nameが空では登録できないこと' do
        @idea_category.name = nil
        @idea_category.valid?
        expect(@idea_category.errors.full_messages).to include("Name can't be blank")
      end

      it 'nameは255文字以内であること' do
        @idea_category.name = 'a' * 256
        @idea_category.valid?
        expect(@idea_category.errors.full_messages).to include('Name is too long (maximum is 255 characters)')
      end

      it 'nameが空では登録できないこと' do
        @idea_category.body = nil
        @idea_category.valid?
        expect(@idea_category.errors.full_messages).to include("Body can't be blank")
      end
    end
  end
end
