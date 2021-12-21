class AddDueDateToTodo < ActiveRecord::Migration[6.1]
  def change
    add_column :todos, :due_date, :datetime
  end
end
