class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :image
      t.float :price, null: false
      t.integer :count, default: 0, null: false
      t.integer :prior, default: 9, null: false
      t.boolean :hided, default: false, null: false

      t.timestamps null: false
    end
    add_index :products, :hided
    add_index :products, :prior
  end
end
