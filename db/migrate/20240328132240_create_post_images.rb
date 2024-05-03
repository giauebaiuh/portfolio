class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|
      
      t.string :trade_name #商品名
      t.text :caption
      t.integer :user
      t.timestamps
    end
  end
end
