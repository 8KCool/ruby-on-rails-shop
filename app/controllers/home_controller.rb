class HomeController < FrontendController
  def index
    @products_list = Product.visibles.ordered

    respond_to do |format|
      format.html
    end

  end

  def cart
  end
end
