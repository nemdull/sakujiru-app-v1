class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :art_title
      t.text :art_text

      t.timestamps
    end
  end
end
