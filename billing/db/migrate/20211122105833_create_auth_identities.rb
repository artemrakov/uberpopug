class CreateAuthIdentities < ActiveRecord::Migration[6.1]
  def change
    create_table :auth_identities do |t|
      t.string :uid
      t.string :provider
      t.string :token
      t.string :login
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
