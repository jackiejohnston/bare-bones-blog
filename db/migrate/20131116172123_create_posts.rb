class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :headline
      t.string :slug
      t.text :intro
      t.text :article

      t.timestamps
    end
    add_index :posts, :slug, unique: true
  end
end
