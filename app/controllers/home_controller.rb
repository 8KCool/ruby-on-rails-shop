class HomeController < FrontendController
  def index
    @products_list = Product.visibles.ordered.page params[:page]

    respond_to do |format|
      format.html do
        if request.xhr?
          render "index_short", layout: false
        else
          render "index"
        end
      end
    end

  end
end
