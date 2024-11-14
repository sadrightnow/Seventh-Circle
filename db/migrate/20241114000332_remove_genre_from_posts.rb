class RemoveGenreFromPosts < ActiveRecord::Migration[8.0]
  def change
    remove_column :posts, :genre, :string
  end
end