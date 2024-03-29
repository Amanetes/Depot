# frozen_string_literal: true

class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: %i[new create]
  before_action :ensure_cart_isnt_empty, only: %i[new]
  before_action :set_order, only: %i[show edit update destroy]
  skip_before_action :authorize, only: %i[new create]

  def index
    @orders = Order.all
  end

  def show; end

  def new
    @order = Order.new
  end

  def edit; end

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        ChargeOrderJob.perform_later(@order,pay_type_params.to_h)
        format.html { redirect_to store_index_url(locale: I18n.locale), notice: I18n.t('.thanks') }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def pay_type_params
    case order_params[:pay_type]
    when 'Credit card'
      params.require(:order).permit(:credit_card_number, :expiration_date)
    when 'Check'
      params.require(:order).permit(:routing_number, :account_number)
    when 'Purchase order'
      params.require(:order).permit(:po_number)
    else
      {}
    end
  end

  def ensure_cart_isnt_empty
    return unless @cart.line_items.empty?

    redirect_to store_index_url, notice: 'Your cart is empty'
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type)
  end
end
