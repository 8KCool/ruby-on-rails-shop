class OrderController < FrontendController
  def make

    @total_price = 0

    @cart_list =  params[:idCount].map do |key, value|
      product = Product.visibles.find_by(id: value['id'])
      if (product.saleprice > 0 && product.saletime > DateTime.now)
        @total_price += product.saleprice * value['count'].to_i
        {
          product_id: product.id,
          count: value['count'].to_i,
          price: product.saleprice
        }
      else
        @total_price += product.price * value['count'].to_i
        {
          product_id: product.id,
          count: value['count'].to_i,
          price: product.price
        }
      end
    end

    Order.create!({ total: @total_price.round(2), order_items_attributes: @cart_list });

    render nothing: true

  end
end
