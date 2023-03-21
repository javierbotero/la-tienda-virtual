class CreateBillings < ActiveRecord::Migration[7.0]
  def change
    create_table :billings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :card_number, null: false
      t.integer :type_card, default: 0, null: false
      t.string :csv, null: false
      t.date :expiration, null: false

      t.timestamps
    end
  end
end
