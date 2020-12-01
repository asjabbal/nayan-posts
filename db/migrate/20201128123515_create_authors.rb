class CreateAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :authors do |t|
      t.string :external_id
      t.string :name

      t.timestamps
    end
  end
end
