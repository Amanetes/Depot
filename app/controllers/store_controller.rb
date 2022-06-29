# frozen_string_literal: true

class StoreController < ApplicationController
  before_action :count_visits, only: %i[index]
  def index
    @products = Product.order(:title)
  end

  private

  def count_visits
    session[:counter] ||= 0
    session[:counter] += 1
    @session_counter = session[:counter]
  end
end
