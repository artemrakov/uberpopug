class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :email
      t.string :password_digest
      t.string :full_name
      t.string :state
      t.string :role
      t.string :position
      t.uuid :public_id, default: 'gen_random_uuid()', null: false

      t.timestamps
    end
  end
end
