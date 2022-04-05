class AddStreetToShelters < ActiveRecord::Migration[5.2]
  def change
    add_column :shelters, :street, :string
  end
end
