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

#form html: { multipart: true } do |f|
#    f.inputs "" do
#
#      f.input :name
#      f.input :image, hint:
#        [ "Изображение будет уменьшено до размеров 280 на 150 пикселей, если оно большего размера.",
#          f.object.image? ? "<br>Текущее изображение:<br>#{image_tag(f.object.image.url)}" : ""
#        ].join.html_safe
#
#      f.input :price
#      f.input :count
#      f.input :prior
#      f.input :hided
#    end
#
# Seo::FormtasticSeoFieldset::build f
#
#    f.actions
#end

end