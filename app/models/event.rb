class Event < ActiveRecord::Base

  belongs_to :store

  validates_presence_of :start_at, :title

  def display_event
  	"#{self.title}"
  end
end
