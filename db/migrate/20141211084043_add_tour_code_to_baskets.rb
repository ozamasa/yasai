class AddTourCodeToBaskets < ActiveRecord::Migration
  def change
    add_column :baskets, :tour_code, :string, after: :id
  end
end
