class CreateLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :line_items do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :quantity, default: 0, null: false

      t.timestamps
    end
  end
end
