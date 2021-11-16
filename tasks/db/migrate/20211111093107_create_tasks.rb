class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :description
      t.string :status
      t.references :employee, null: false, foreign_key: { to_table: 'accounts' }

      t.timestamps
    end
  end
end
