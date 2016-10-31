class OrderController < FrontendController
  def make

    @total_price = 0

    @cart_list =  params[:idCount].map do |key, value|
      product = Product.visibles.find_by(id: value['id'])
        @total_price += product.curprice * value['count'].to_i
        {
          product_id: product.id,
          count: value['count'].to_i,
          price: product.curprice
        }
    end

    Order.create!({ total: @total_price.round(2), order_items_attributes: @cart_list });

    render nothing: true

  end
end
