class AddUserCommentToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :user_comment, :text
  end
end
