# frozen_string_literal: true

class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  before_action :count_visits, only: %i[index]
  skip_before_action :authorize
  def index
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
  end
end
