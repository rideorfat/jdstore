class Order < ApplicationRecord
  before_action :authenticate_user!, only: [:create]
  belongs_to :user
  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :shipping_name, presence: true
  validates :shipping_address, presence: true

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total = current_cart.total_price

    if @order.save
      redirect_to order_path(@order)
    else
      reder 'carts/checkout'
    end

    private

    def order_params
      params.require(:order).permit(:billing_name, :billing_address, :shipping_name, :shipping_address)
    end
end
