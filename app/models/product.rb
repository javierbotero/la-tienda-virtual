class Product < ApplicationRecord
  enum api_url: {
    'https://fakestoreapi.com/products' => 0,
    'https://dummyjson.com/products' => 1
  }

  scope :sort_by_title_price, -> { order(:title, :price) }
  scope :filter_by_title_price, -> (str, min, max) do
    query = all
    query = query.where('title ILIKE ?', "%#{str}%") if str.present?
    query = query.where('price >= ?', min) if min.present?
    query = query.where('price <= ?', max) if max.present?
    query.sort_by_title_price
  end
end
