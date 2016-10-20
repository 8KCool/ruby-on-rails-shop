class ProductsImageUploader < BaseImageUploader

  version :standard do
    process resize_to_fill: [277, 300]
  end

  version :cartversion do
    process resize_to_fill: [75, 75]
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    ActionController::Base.helpers.asset_path("fallback/pi_" + [version_name, "default.png"].compact.join('_'))

    #"/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

end