class RemoveArticlesColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :photo, :photo_url
  end
end
