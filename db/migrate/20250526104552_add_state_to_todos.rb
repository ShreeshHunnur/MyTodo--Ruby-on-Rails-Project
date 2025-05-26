class AddStateToTodos < ActiveRecord::Migration[7.1]
  def change
    add_column :todos, :state, :string, default: 'pending'
    add_index :todos, :state
  end
end
