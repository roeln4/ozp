class AddPropertiesToFace < ActiveRecord::Migration[7.0]
  def change
    add_column :faces, :name, :string
    add_column :faces, :url, :string
  end
end
