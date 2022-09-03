# frozen_string_literal: true

# No line item can exist unless the corresponding cart and product rows exist
class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_price
    product.price * quantity
  end
end
