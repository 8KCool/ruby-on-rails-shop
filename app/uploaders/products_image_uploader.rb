class ProductsImageUploader < BaseImageUploader

  version :standard do
    process resize_to_fill: [277, 300]
  end

  version :cartversion do
    process resize_to_fill: [75, 75]
  end

end