class AddPrefectureToPostImage < ActiveRecord::Migration[6.1]
  def change
    add_column :post_images, :prefecture, :integer
  end
end
