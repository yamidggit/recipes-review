class DropCategoriesRecipesTyping < ActiveRecord::Migration
  def change
    drop_table :categories_recipies
  end
end
