module ApplicationHelper
  def img_tag(file_name, options = {})
  	return if file_name.blank?
  	path = "/images/" + file_name
  	image_tag path, width: options[:width], class: options[:class]
  end

  def wday_tag(date)
  	%w(日 月 火 水 木 金 土)[date.wday]
  end

  def wday_color_class(date)
    ['danger', 'active', 'active', 'active', 'active', 'active', 'info'][date.wday]
  end

  def today_class(date)
    'today' if date == Date.today
  end

  def auth_class(idx)
    return unless idx
    %w(primary danger success info)[idx - 1]
  end

  def hbr(str)
    return if str.blank?
    raw str.gsub(/\r\n|\r|\n/, "<br />\n")
  end

end
