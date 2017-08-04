class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :direction
      t.string :photo_link
      t.integer :user_id
      t.timestamps
    end
  end
end
