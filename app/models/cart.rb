# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  # Проверяет, содержит ли наш список товаров уже добавляемый продукт;
  # если да, то увеличивает количество, а если нет, то создает новый LineItem
  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id)
      current_item&.price = product.price
    end
    current_item
  end

  def total_price
    line_items.sum(&:total_price)
  end
end
