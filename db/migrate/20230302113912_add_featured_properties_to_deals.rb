class AddFeaturedPropertiesToDeals < ActiveRecord::Migration[7.0]
  def change
    add_column :deals, :city, :string
    add_column :deals, :short_title, :string
    add_column :deals, :price, :integer
    add_column :deals, :what_to_expect, :text
    add_column :deals, :about, :text
    add_column :deals, :offer_id, :string
  end
end
