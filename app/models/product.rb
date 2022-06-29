# frozen_string_literal: true

class Product < ApplicationRecord
  validates :title, presence: true
end
