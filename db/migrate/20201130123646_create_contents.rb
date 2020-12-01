class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.references :post, null: true, foreign_key: true
      t.integer :parent_content_id
      t.json :data
      t.string :node_type
      t.json :marks
      t.text :value

      t.timestamps
    end
  end
end
