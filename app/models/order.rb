class Order < ActiveRecord::Base

  belongs_to :tour
  
  has_many :order_items
  accepts_nested_attributes_for :order_items

end
