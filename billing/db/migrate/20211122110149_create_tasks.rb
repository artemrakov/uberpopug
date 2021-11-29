class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :description
      t.string :cost
      t.string :public_id

      t.timestamps
    end
  end
end
