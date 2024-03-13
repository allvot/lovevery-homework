class OrdersController < ApplicationController
  def new
    @order_form = OrderForm.new(form_params)
  end

  def create
    child = Child.find_or_create_by(child_params)
    @order = Order.create(order_params.merge(child: child, user_facing_id: SecureRandom.uuid[0..7]))

    if @order.valid?
      Purchaser.new.purchase(@order, credit_card_params)
      redirect_to order_path(@order)
    else
      @order_form = OrderForm.new(form_params)
      render :new
    end
  end

  def show
    @order = Order.find_by(id: params[:id]) || Order.find_by(user_facing_id: params[:id])
  end

private

  def product_id
    params[:product_id] || params[:order_form][:product_id]
  end

  def form_params
    params.fetch(:order_form, {})
          .permit(
            :shipping_name, :product_id, :zipcode,
            :address, :child_full_name, :shipping_name,
            :child_birthdate, :credit_card_number, :expiration_month,
            :expiration_year
          ).tap { |prms| prms[:product_id] ||= params[:product_id] }
  end

  def order_params
    params.require(:order_form).permit(:shipping_name, :product_id, :zipcode, :address).merge(paid: false)
  end

  def child_params
    {
      full_name: params.require(:order_form)[:child_full_name],
      parent_name: params.require(:order_form)[:shipping_name],
      birthdate: Date.parse(params.require(:order_form)[:child_birthdate]),
    }
  end

  def credit_card_params
    params.require(:order_form).permit(:credit_card_number, :expiration_month, :expiration_year)
  end
end
