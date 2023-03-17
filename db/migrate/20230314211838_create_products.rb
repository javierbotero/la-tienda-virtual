class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.integer :api_url, default: 0, null: false
      t.string :external_id, null: false
      t.string :title, null: false
      t.text :description
      t.integer :stock, default: 0, null: false
      t.decimal :price, null: false
      t.string :images, null: false

      t.timestamps
    end

    add_index :products, [:api_url, :external_id], unique: true
  end
end
