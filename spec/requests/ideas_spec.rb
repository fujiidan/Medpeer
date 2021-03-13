require 'rails_helper'

RSpec.describe "Ideas", type: :request do
  before do
    @idea_category = build(:idea_category)
    @post_params = { idea: { name: @idea_category.name, body: @idea_category.body }}
  end  
  describe 'idea投稿APIテスト' do

    context 'idea投稿できるとき' do

      it 'idea作成に成功するとステータスコード201を返すこと(categoryの重複が無い場合)' do
        expect{ post ideas_path, params: @post_params }.to change{ Category.count }.by(1).and change{ Idea.count }.by(1)
        expect(response.status).to eq 201
      end

      it 'idea作成に成功するとステータスコード201を返すこと(categoryの重複がある場合)' do
        create(:category, name: @idea_category.name)
        expect{ post ideas_path, params: @post_params }.to change{ Category.count }.by(0).and change{ Idea.count }.by(1)
        expect(response.status).to eq 201
      end
    end

    context 'idea作成に失敗したとき' do

      it 'idea作成に失敗するとステータスコード422を返すこと' do
        expect{ post ideas_path, params: { idea: { name: "", body: "" }}}.to change{ Category.count }.by(0).and change{ Idea.count }.by(0)
        expect(response.status).to eq 422
      end  
    end
  end

  describe 'idea検索機能APIテスト' do

    before do
      @categories = create_list(:category, 2)
      @ideas1 = create_list(:idea, 2, category_id: @categories[0].id)
      @ideas2 = create_list(:idea, 2, category_id: @categories[1].id)
    end

    context 'idea検索できるとき' do

      it 'category_nameに該当するcategoryに紐づくideaのデータがレスポンスされ、ステータスコード200を返すこと' do
        get search_ideas_path, params: { category_name: @categories[0].name }
        data = JSON.parse(response.body)['data']
        expect(response.status).to eq 200
        expect(data.length).to eq 2
        expect(data[0]['body']).to include @ideas1[0].body
        expect(data[0]['category']).to include @categories[0].name
      end

      it 'category_nameの指定がない場合全てのideaのデータがレスポンスされ、ステータスコード200を返すこと' do
        get search_ideas_path, params: { category_name: "" }
        data = JSON.parse(response.body)['data']
        expect(response.status).to eq 200
        expect(data.length).to eq 4
      end
    end

    context 'idea検索に失敗したとき' do

      it 'category_nameに該当するcategoryがない場合、ステータスコード404を返すこと' do
        get search_ideas_path, params: { category_name: "no_match_category" }
        expect(response.status).to eq 404
      end
    end  
  end      
end
