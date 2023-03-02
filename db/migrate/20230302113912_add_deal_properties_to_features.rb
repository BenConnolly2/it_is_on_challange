class AddDealPropertiesToFeatures < ActiveRecord::Migration[7.0]
  def change
    add_column :features, :city, :string
    add_column :features, :short_title, :string
    add_column :features, :price, :integer
  end
end
