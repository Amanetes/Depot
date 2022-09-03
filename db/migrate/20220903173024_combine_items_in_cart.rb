# Начинаем с итерации по каждой корзине.
# Для каждой корзины мы получим сумму полей количества для каждой из позиций, связанных с этой корзиной, сгруппированных по идентификатору товара.
# Полученные суммы будут представлять собой список упорядоченных пар product_ids и quantity.
# Мы перебираем эти суммы, извлекая из каждой из них идентификатор товара и количество.
# В случаях, когда количество больше единицы, мы удаляем все отдельные линейные позиции, связанные с этой корзиной и этим продуктом,
# и заменяем их одной линейной позицией с правильным количеством.

class CombineItemsInCart < ActiveRecord::Migration[7.0]
  def up
    # заменить несколько элементов для одного товара в корзине на один элемент
    Cart.all.each do |cart|
      # подсчет количества каждого товара в корзине
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          # удалить отдельные элементы
          cart.line_items.where(product_id: product_id).delete_all
          # заменить на один элемент
          item = cart.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end

  def down
    # разделить элементы с количеством > 1 на несколько элементов
    LineItem.where("quantity>1").each do |line_item|
      # добавить отдельный элемент
      line_item.quantity.times do
        LineItem.create(
          cart_id: line_item.cart_id,
          product_id: line_item.product_id,
          quantity: 1
        )
      end
      # удалить исходный элемент
      line_item.destroy
    end
  end
end
