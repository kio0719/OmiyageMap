class RenamePlaceColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :place, :address
  end
end
