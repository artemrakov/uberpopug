class AddPublicIdToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :public_id, :uuid, default: 'gen_random_uuid()', null: false
  end
end
