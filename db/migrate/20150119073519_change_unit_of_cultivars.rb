class ChangeUnitOfCultivars < ActiveRecord::Migration
  def change
  	change_column :cultivars, :unit, :string
  end
end
