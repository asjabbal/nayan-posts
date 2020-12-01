class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :external_id
      t.references :author, null: true, foreign_key: true
      t.string :title
      t.string :image_url

      t.timestamps
    end
  end
end
