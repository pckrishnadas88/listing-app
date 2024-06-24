class AddPriceToListings < ActiveRecord::Migration[7.1]
  def change
    add_column :listings, :price, :decimal, :precision => 8, :scale => 2, null:false, default:0
  end
end
