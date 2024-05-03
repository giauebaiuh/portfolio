class RemoveGenreFromPostImage < ActiveRecord::Migration[6.1]
  def change
    remove_column :post_images, :genre, :string
  end
end
