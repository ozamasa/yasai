class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string, after: :name_kana
    add_column :users, :auth,  :integer, after: :name_kana
  end
end
