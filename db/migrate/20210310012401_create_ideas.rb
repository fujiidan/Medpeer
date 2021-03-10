class CreateIdeas < ActiveRecord::Migration[6.0]
  def change
    create_table :ideas do |t|
      t.text :body, null: false
      t.bigint :category_id, null:false
      t.timestamps
    end
  end
end
