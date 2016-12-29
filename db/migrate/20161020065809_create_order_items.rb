class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :count
      t.float :price
      t.belongs_to :product
      t.belongs_to :order

      t.timestamps null: false
    end
  end
end
