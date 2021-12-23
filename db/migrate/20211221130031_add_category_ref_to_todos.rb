class AddCategoryRefToTodos < ActiveRecord::Migration[6.1]
  def change
    add_reference :todos, :category, foreign_key: true
  end
end
