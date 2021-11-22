class CreateBillingCycles < ActiveRecord::Migration[6.1]
  def change
    create_table :billing_cycles do |t|
      t.string :status
      t.string :period
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
