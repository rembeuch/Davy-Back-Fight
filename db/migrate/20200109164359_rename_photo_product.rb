class RenamePhotoProduct < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :photo_url, :photo
  end
end
