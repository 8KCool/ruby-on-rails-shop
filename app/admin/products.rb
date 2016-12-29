ActiveAdmin.register Product do
  permit_params :name, :image, :price, :saleprice, :saletime, :count, :prior, :hided, :category_id

  ### Disable some actions
  actions :all

  ### Index as table
  index download_links: false do
    selectable_column
    column :name
    column :image do |product|
      image_tag(product.image.cartversion.url)
    end
    # column (:image) { image_tag(self.image.url(:standard)) unless self.image.blank? }
    column :price
    column :saleprice
    column :saletime
    column :count
    column :prior
    column :hided
    column :created_at
    column :updated_at
    column :category
    actions
  end

  filter :name
  filter :price
  filter :saleprice
  filter :saletime
  filter :count
  filter :prior
  filter :hided
  filter :created_at
  filter :updated_at
  filter :category

  batch_action :show, confirm: "Уверены?" do |ids|
    Product.find(ids).each do |product|
      product.update hided: false
    end
    redirect_to collection_path, alert: "У указанных товаров убран флаг скрытия."
  end
  batch_action :hide, confirm: "Уверены?" do |ids|
    Product.find(ids).each do |product|
      product.update hided: true
    end
    redirect_to collection_path, alert: "Указанные товары были скрыты."
  end

## SHOW

  show do

    attributes_table do
      row :name
      row (:image) { image_tag(product.image.url) }
      row :price
      row :saleprice
      row :saletime
      row :count
      row :prior
      row :category
    end

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
        [ "Изображение будет уменьшено до размеров 277 на 300 пикселей, если оно большего размера.",
          f.object.image? ? "<br>Текущее изображение:<br>#{image_tag(f.object.image.url(:standard))}" : ""
        ].join.html_safe

      f.input :price
      f.input :saleprice
      f.input :saletime
      f.input :count
      f.input :prior, hint: "Чем меньше значение, тем раньше отображается продукт в списке."
      f.input :hided
      f.input :category, include_blank: false
    end

    f.actions
end

end