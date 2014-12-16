module ApplicationHelper
  def img_tag(file_name, options = {})
  	return if file_name.blank?
  	path = "/images/" + file_name
  	image_tag path, width: options[:width], class: options[:class]
  end
end
