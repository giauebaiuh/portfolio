class AddStarToPostImage < ActiveRecord::Migration[6.1]
  def change
    add_column :post_images, :star, :float
  end
end
