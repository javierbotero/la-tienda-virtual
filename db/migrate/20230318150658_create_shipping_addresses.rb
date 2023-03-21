class CreateShippingAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :address, null: false
      t.string :country, null: false
      t.string :state, null: false
      t.string :city, null: false
      t.string :zipcode, null: false

      t.timestamps
    end
  end
end
