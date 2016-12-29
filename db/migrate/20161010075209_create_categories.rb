class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string  :name, null: false
      t.boolean :hided, default: false, null: false

      t.timestamps null: false
    end

    add_index :categories, :hided
  end
end
