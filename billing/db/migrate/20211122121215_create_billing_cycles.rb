class CreateBillingCycles < ActiveRecord::Migration[6.1]
  def change
    create_table :billing_cycles do |t|
      t.string :status
      t.datetime :started_at
      t.datetime :ended_at
      t.uuid :public_id, default: 'gen_random_uuid()', null: false
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
