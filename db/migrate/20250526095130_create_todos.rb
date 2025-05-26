class CreateTodos < ActiveRecord::Migration[8.0]
  def change
    create_table :todos do |t|
      t.string :name , null: false
      t.text :description , null: false

      t.timestamps
    end
  end
end
