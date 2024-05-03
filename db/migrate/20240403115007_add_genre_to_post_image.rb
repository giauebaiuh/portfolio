class AddGenreToPostImage < ActiveRecord::Migration[6.1]
  def change
    add_column :post_images, :genre, :integer
  end
end
