class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :name, null: false, default: ""
      t.references :user, null: false, foreign_key: true
      t.float :balance, null: false, default: 0

      t.timestamps
    end
  end
end
