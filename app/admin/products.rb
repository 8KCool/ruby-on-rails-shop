ActiveAdmin.register Product do
  permit_params :name, :image, :price, :count, :prior, :hided

  ### Disable some actions
  actions :all

  ### Index as table
  index download_links: false do
    column :name
    column :image
    column :price
    column :count
    column :prior
    column :hided
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :price
  filter :count
  filter :prior
  filter :hided
  filter :created_at
  filter :updated_at

## SHOW

  show do

    attributes_table do
      row :name
      row (:image) { image_tag(product.image.url) unless product.image.blank? }
      row :price
      row :count
      row :prior
    end

    #seo_panel_for news

    #static_files_for news
  end

  sidebar 'Дополнительные данные', only: :show do
    attributes_table_for product do
      row(:hided) { product.hided? ? t('yep') : t('nope') }
      row :created_at
      row :updated_at
    end
  end


form html: { multipart: true } do |f|
    f.inputs "" do

      f.input :name
      f.input :image, hint:
        [ "Изображение будет уменьшено до размеров 279 на 300 пикселей, если оно большего размера.",
          f.object.image? ? "<br>Текущее изображение:<br>#{image_tag(f.object.image.url(:standard))}" : ""
        ].join.html_safe

      f.input :price
      f.input :count
      f.input :prior
      f.input :hided
    end

    #Seo::FormtasticSeoFieldset::build f

    f.actions
end

end