class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :qmemo
      t.text :amemo
      t.string :address
      t.integer :comprehension
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
