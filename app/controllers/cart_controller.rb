class CartController < FrontendController
  def index
  end

  def cartls

    @cart_list =  params[:idCount].map { |key, value| Product.find_by(id: value['id']) }

    @count_list = []

    params[:idCount].each do |key, value|
      @count_list.push(value['count'])
    end

    @total_price = 0

    @cart_list.zip(@count_list).each do |cart, count|
      if (cart && cart.hided)
        if (cart.saleprice > 0 && cart.saletime > DateTime.now)
          @total_price += cart.saleprice * count.to_f
        else
          @total_price += cart.price * count.to_f
        end
      end
    end

    respond_to do |format|
      format.html do
        render "cartls", layout: false
      end
    end
  end
end
