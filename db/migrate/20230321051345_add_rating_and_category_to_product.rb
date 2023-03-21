class AddRatingAndCategoryToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :category, :string
    add_column :products, :rating, :decimal
  end
end
