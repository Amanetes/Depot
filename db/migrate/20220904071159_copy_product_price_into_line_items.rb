class CopyProductPriceIntoLineItems < ActiveRecord::Migration[7.0]
  def up
    # скопировать цену из продукта, чтобы line_items могли отражать цену
    # товаров при добавлении продукта
    LineItem.all.each do |line_item|
      product = Product.find(line_item.product_id)
      line_item.price = product.price
      line_item.save!
    end
  end

  def down
    LineItem.all.each do |line_item|
      line_item.price = nil
      line_item.save!
    end
  end
end
