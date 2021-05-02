class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :item, null: false
      t.text :description, null: false
      t.references :prefecture, null: false, foreign_key:true
      t.references :city, null: false, foreign_key:true
      t.references :user, null: false, foreign_key:true

      t.timestamps
    end
  end
end
