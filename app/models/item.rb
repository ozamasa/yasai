class Item < ActiveRecord::Base

  belongs_to :cultivar
  belongs_to :producer, class_name: "User"
  has_one :basket

end
