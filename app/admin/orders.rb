ActiveAdmin.register Order do
  permit_params :total, :status, order_items_attributes: [:product_id, :count, :price, :_destroy]
  ### Disable some actions
  actions :all

  ### Index as table
  index download_links: false do
    selectable_column
    # column "slug", :slug, sortable: :slug do |post|
    #   link_to post.slug, post_path(post.slug), target: '_blank'
    # end
    # column "slug", :slug, sortable: :slug do |post|
    #   link_to post.slug, post_path(post.slug), target: '_blank'
    # end
    column :total
    column :status
    column :created_at
    column :updated_at
    actions
  end

  filter :total
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
      row (:total) {"$" + order.total.to_s }
      row ("Список продуктов") { order.order_items.product }
      row ("Количество продуктов") { "Заказано: " + order.order_items.pluck(:count).join(', ') + " На складе: " + order.products.pluck(:count).join(', ')}
      row ("Цена товара на момент заказа") { "$" + order.order_items.pluck(:price).join(', $') }
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


  form html: { multipart: true } do |f|
      f.inputs "" do

        f.input :total
        f.input :status
      end

      #Seo::FormtasticSeoFieldset::build f

      f.inputs do
        f.has_many :order_items, { heading: 'Заказанные товары',
                            new_record: 'Добавить товар',
                            allow_destroy: true,
                            sortable: :created_at } do |a|
          a.input :product, include_blank: false
          a.input :count
          a.input :price
        end
      end

      f.actions
  end
end