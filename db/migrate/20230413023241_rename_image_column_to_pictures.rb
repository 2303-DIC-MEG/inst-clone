class RenameImageColumnToPictures < ActiveRecord::Migration[6.1]
  def change
    rename_column :pictures, :image, :picture
  end
end
