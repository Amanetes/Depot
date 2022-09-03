# frozen_string_literal: true

class StoreController < ApplicationController
  before_action :count_visits, only: %i[index]
  def index
    @products = Product.order(:title)
  end
end
