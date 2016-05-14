class RemoveColumn < ActiveRecord::Migration
  def change
    remove_column :recipes, :category_id, :integer
  end
end
