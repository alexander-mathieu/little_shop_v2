class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.boolean :active
      t.decimal :price
      t.text :description
      t.string :image
      t.integer :inventory

      t.timestamps
    end
  end
end
