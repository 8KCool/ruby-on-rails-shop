class ProductsImageUploader < BaseImageUploader

  version :standard do
    process resize_to_fill: [277, 300]
  end

  version :cartversion do
    process resize_to_fill: [75, 75]
  end

  def default_url
    ActionController::Base.helpers.asset_path("fallback/pi_" + [version_name, "default.png"].compact.join('_'))
  end

end