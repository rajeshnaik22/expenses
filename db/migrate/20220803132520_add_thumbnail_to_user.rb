class AddThumbnailToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :thumbnail, :string
  end
end
