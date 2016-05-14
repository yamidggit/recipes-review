class JoinTableCategoriesRecipes < ActiveRecord::Migration
  def change
      create_table :categories_recipies, id: false do |t|
      t.belongs_to :category, index: true
      t.belongs_to :recipie, index: true
    end
  end
end
