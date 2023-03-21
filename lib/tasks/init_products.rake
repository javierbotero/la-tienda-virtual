require 'net/http'
require 'json'

namespace :init do
  desc "Find or create product records"
  task products: :environment do
    url1 = URI("https://fakestoreapi.com/products")
    res1 = Net::HTTP.get(url1)
    products_data1 = JSON.parse(res1)

    url2 = URI("https://dummyjson.com/products")
    res2 = Net::HTTP.get(url2)
    products_data2 = JSON.parse(res2)

    products_data1.each do |product_data|
      create_product("https://fakestoreapi.com/products", product_data)
    end
    products_data2['products'].each do |product_data|
      create_product("https://dummyjson.com/products", product_data)
    end
  end
end

def create_product(url, product_data)
  Product.find_or_create_by!(
    api_url: url,
    external_id: product_data['id'],
    title: product_data['title'],
    description: product_data['description'],
    stock: product_data['stock'] ? product_data['stock'] : 0,
    price: product_data['price'],
    images: product_data['images'] ? product_data['images'].join(',') : product_data['image'],
    category: product_data['category'],
    rating: product_data['rating'].is_a?(Hash) ? product_data['rating']['rate'] : product_data['rating']
  )
end
