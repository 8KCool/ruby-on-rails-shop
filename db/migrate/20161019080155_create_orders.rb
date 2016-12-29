class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.float :total, null: false
      t.integer :status, null: false, default: 0

      t.timestamps null: false
    end
    add_index :orders, :status
  end
end
