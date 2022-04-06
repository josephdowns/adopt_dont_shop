class AddZipToShelters < ActiveRecord::Migration[5.2]
  def change
    add_column :shelters, :zip, :integer
  end
end
