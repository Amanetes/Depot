# frozen_string_literal: true

class Product < ApplicationRecord
  before_destroy :ensure_not_referenced_by_any_line_item

  has_many :line_items, dependent: :destroy

  validates :title, :description, :image_url, presence: true
  validates :title, uniqueness: true, length: { minimum: 10 }
  validates :image_url, allow_blank: true, format: { # allow_blank игнорирует валидацию если стоит вместе с presence: true
    with: /\.(gif|jpg|png)\z/i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  private

  # Ensure that there are no line items referencing this product

  def ensure_not_referenced_by_any_line_item
    return if line_items.empty?

    errors.add(:base, 'Line Items present')
    throw :abort
  end
end
