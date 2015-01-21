class Event < ActiveRecord::Base

  validates_presence_of :start_at, :title

  def display_event
  	"#{self.title}(#{self.place})"
  end
end
