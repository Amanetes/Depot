class CopyProductPriceToLineItems < ActiveRecord::Migration[7.0]
  def up
    # Copy the price from product so line items are able to reflect the price of products when added
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
