class CreateTodos < ActiveRecord::Migration[7.1]
  def change
  
    create_enum :status, [:pending, :in_progress, :completed], null: false, default: 0

    create_table :todos do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.date :due_date, null: false
      t.enum :current_status, default: :pending, null: false, enum_type: :status

      t.timestamps
    end
    
  end
end
