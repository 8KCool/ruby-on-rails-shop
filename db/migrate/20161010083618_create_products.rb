class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :image
      t.float :price, null: false
      t.float :saleprice, default: 0
      t.datetime :saletime
      t.integer :count, default: 0, null: false
      t.integer :prior, default: 9, null: false
      t.boolean :hided, default: false, null: false
      t.belongs_to :category

      t.timestamps null: false
    end
    add_index :products, :hided
    add_index :products, :prior
  end
end
