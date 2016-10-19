ActiveAdmin.register Order do
  permit_params :products, :count, :cost, :status

  ### Disable some actions
  actions :all

  ### Index as table
  index download_links: false do
    selectable_column
    column :products
    column :count
    column :cost
    column :status
    column :created_at
    column :updated_at
    actions
  end

  filter :cost
  filter :created_at
  filter :updated_at

  batch_action :waiting, confirm: "Уверены?" do |ids|
    Order.find(ids).each do |order|
      order.update status: 0
    end
    redirect_to collection_path, alert: "Изменен статус заказа на: Ожидание."
  end

  batch_action :confirmed, confirm: "Уверены?" do |ids|
    Order.find(ids).each do |order|
      order.update status: 1
    end
    redirect_to collection_path, alert: "Изменен статус заказа на: Подтверждён."
  end

  batch_action :rejected, confirm: "Уверены?" do |ids|
    Order.find(ids).each do |order|
      order.update status: 2
    end
    redirect_to collection_path, alert: "Изменен статус заказа на: Отменён."
  end

  batch_action :shipped, confirm: "Уверены?" do |ids|
    Order.find(ids).each do |order|
      order.update status: 4
    end
    redirect_to collection_path, alert: "Изменен статус заказа на: Отгружен."
  end

## SHOW

  show do

    attributes_table do
      row :products
      row :count
      row :cost
      row :status
    end

    #seo_panel_for news

    #static_files_for news
  end

  sidebar 'Дополнительные данные', only: :show do
    attributes_table_for order do
      row :created_at
      row :updated_at
    end
  end

end