class AddPostImageIdToPostComment < ActiveRecord::Migration[6.1]
  def change
    add_column :post_comments, :post_image_id, :integer
    add_column :post_comments, :user_id, :integer
  end
end
