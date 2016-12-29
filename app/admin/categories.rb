ActiveAdmin.register Category do
  permit_params :name, :hided

  ### Disable some actions
  actions :all, except: [:show]

  ### Index as table
  index download_links: false do
    selectable_column
    column :name
    column :hided
    column :created_at
    column :updated_at
    actions
  end

  batch_action :show, confirm: "Уверены?" do |ids|
    Category.find(ids).each do |category|
      category.update hided: false
      Product.where(category_id: ids).each do |product|
        product.update hided: false
      end
    end
    redirect_to collection_path, alert: "У указанной категории товаров убран флаг скрытия."
  end

  batch_action :hide, confirm: "Уверены?" do |ids|
    Category.find(ids).each do |category|
      category.update hided: true
      Product.where(category_id: ids).each do |product|
        product.update hided: true
      end
    end
    redirect_to collection_path, alert: "Указанная категория товаров была скрыта."
  end

end
