# frozen_string_literal: true

# No line item can exist unless the corresponding cart and product rows exist
class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :cart, optional: true

  def total_price
    price * quantity
  end
end
