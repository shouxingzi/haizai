class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :title, null: false
      t.text :text, null: false
      t.references :prefecture, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true    


      t.timestamps
    end
  end
end
