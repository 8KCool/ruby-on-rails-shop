ActiveAdmin.register Order do
  permit_params :total, :status, order_items_attributes: [:id, :product_id, :count, :price, :_destroy]
  ### Disable some actions
  actions :all

  scope "Все", :all
  scope "Ожидание", :waiting, default: true
  scope "Подтвержден", :confirmed
  scope "Отменён", :rejected
  scope "Отгружен", :shipped

  ### Index as table
  index download_links: false do
    selectable_column
    column :id
    column (:total) { |order| "$" + order.total.to_s }
    column ("Список продуктов") { |order| order.order_items.map { |prod| link_to(prod.product.name, admin_product_path(prod.product)) }.join(',<br/>').html_safe  }
    column ("Заказано продуктов") { |order| order.order_items.map { |item| item.count }.join(', <br/>').html_safe }
    column ("Продуктов на складе"){ |order| order.order_items.map { |prod| prod.product.count }.join(', <br/>').html_safe }
    column ("Цена товара на момент заказа") { |order| ("$" + order.order_items.map { |item| item.price }.join(',<br/>$')).html_safe}
    column :status, sortable: :status do |order|
      if order.status == 0
        "Ожидание"
      elsif order.status == 1
        "Подтверждён"
      elsif order.status == 2
        "Отменён"
      elsif order.status == 3
        "Отгружен"
      end
    end
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
      order.update status: 3
    end
    redirect_to collection_path, alert: "Изменен статус заказа на: Отгружен."
  end

## SHOW

  show do

    attributes_table do
      row :id
      row (:total) {"$" + order.total.to_s }
      row (:status) {
        if order.status == 0
          "Ожидание"
        elsif order.status == 1
          "Подтверждён"
        elsif order.status == 2
          "Отменён"
        elsif order.status == 3
          "Отгружен"
        end }
    end

    panel "Продукты" do
      table_for order.order_items do
        column :product
        column :count
        column ("Количество на складе") { |order_item| order_item.product.count }
        column (:price) { |order_item| "$" + order_item.price.to_s }
      end
    end

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