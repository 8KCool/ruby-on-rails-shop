class CartController < FrontendController
  def index
  end

  def cartls
    @idsfordel = []

    @cart_list =  params[:idCount].map do |key, value|
      if (Product.visibles.find_by(id: value['id'])) then
        Product.visibles.find_by(id: value['id'])
      else
        @idsfordel.push(value['id'])
        nil
      end
    end

    # puts "Hello World!"

    # @cart_list.each do |cart|
    #   if cart
    #     puts cart.id
    #   end
    # end

    # @idsfordel.each do |id|
    #   puts id
    # end

    @count_list = []

    params[:idCount].each do |key, value|
      @count_list.push(value['count'])
    end

    @total_price = 0

    @cart_list.zip(@count_list).each do |cart, count|
      if cart
        if cart.saletime && cart.saleprice
          have_saleprice = cart.saleprice > 0 && cart.saletime > DateTime.now
        else
          have_saleprice = false
        end

        if have_saleprice
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
